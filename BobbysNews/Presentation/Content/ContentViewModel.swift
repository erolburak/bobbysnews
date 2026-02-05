//
//  ContentViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import Network
import TipKit
import Translation
import WebKit

@Observable
final class ContentViewModel {
    // MARK: - Type Definitions

    enum States {
        // MARK: - Properties

        /// General States
        case isLoading, loaded, isTranslating
        /// Empty States
        case emptyFetch, emptyRead, emptyTranslate
    }

    struct CategoriesTip: Tip {
        // MARK: - Properties

        @Parameter
        static var show: Bool = false
        var image: Image? = Image(systemName: "tag")
        var message: Text? = Text("CategoriesTipMessage")
        var rules: [Rule] {
            [
                #Rule(Self.$show) {
                    $0
                }
            ]
        }

        var title = Text("Categories")
    }

    struct SettingsTip: Tip {
        // MARK: - Properties

        @Parameter
        static var show: Bool = false
        var image: Image? = Image(systemName: "gearshape")
        var message: Text? = Text("SettingsTipMessage")
        var rules: [Rule] {
            [
                #Rule(Self.$show) {
                    $0
                }
            ]
        }

        var title = Text("Settings")
    }

    // MARK: - Use Cases

    private let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
    private let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
    private let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase

    // MARK: - Properties

    let categoriesTip = CategoriesTip()
    let settingsTip = SettingsTip()
    var alertError: Errors?
    var articles = [Article]()
    var categoriesSorted: [Categories] {
        Categories.allCases.sorted { $0.localized < $1.localized }
    }

    var countries: [String] = []
    var countriesSorted: [String] {
        countries.sorted {
            Locale.current.localizedString(forRegionCode: $0) ?? "" < Locale.current
                .localizedString(forRegionCode: $1) ?? ""
        }
    }

    var listDisabled: Bool { state != .loaded }
    var listOpacity: Double { state == .loaded ? 1 : 0.3 }
    var selectedApiKey = ""
    var selectedApiKeyConfirmDisabled: Bool {
        selectedApiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var selectedCategory: Categories = .general
    var selectedCountry = ""
    var sensoryFeedback: SensoryFeedback?
    var sensoryFeedbackBool = false
    var showAlert = false
    var showEditAlert = false
    var showNoNetworkConnection = false
    var showResetConfirmationDialog = false
    var showWebView = false
    var state: States = .isLoading
    var translate = false
    var translateDisabled = true
    var translationSessionConfiguration: TranslationSession.Configuration?
    var webPage: WebPage?

    // MARK: - Lifecycles

    init(
        deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase,
        fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase,
        readTopHeadlinesUseCase: PReadTopHeadlinesUseCase
    ) {
        self.deleteTopHeadlinesUseCase = deleteTopHeadlinesUseCase
        self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
        self.readTopHeadlinesUseCase = readTopHeadlinesUseCase
        configureTipKit()
    }

    // MARK: - Methods

    func onAppear(
        selectedApiKey: String,
        selectedCategory: Categories,
        selectedCountry: String
    ) {
        self.selectedApiKey = selectedApiKey
        self.selectedCategory = selectedCategory
        self.selectedCountry = selectedCountry
        readCountries()
        readTopHeadlines()
    }

    @MainActor
    func configureTranslations() async {
        guard await checkNetworkConnection() == true else {
            translate = false
            return
        }
        if translate,
            translationSessionConfiguration == nil
        {
            translationSessionConfiguration = TranslationSession.Configuration()
        } else if translate {
            translationSessionConfiguration?.invalidate()
        } else {
            showArticlesTranslations(show: false)
        }
    }

    @MainActor
    func fetchTopHeadlines(
        state: States? = nil,
        sensoryFeedback: Bool? = nil
    ) async {
        if sensoryFeedback == true {
            self.sensoryFeedback(.success)
        }
        if !selectedApiKey.isEmpty,
            !selectedCountry.isEmpty
        {
            if let state {
                self.state = state
            }
            do {
                if await checkNetworkConnection() == true {
                    try await fetchTopHeadlinesUseCase.fetch(
                        apiKey: selectedApiKey,
                        category: selectedCategory.rawValue,
                        country: selectedCountry)
                }
                translate = false
                readTopHeadlines()
            } catch {
                updateStateTopHeadlines(
                    error: error as? LocalizedError,
                    state: articles.isEmpty ? .emptyFetch : .loaded
                )
            }
        }
    }

    @MainActor
    func fetchTranslations(translateSession: TranslationSession) async {
        state = .isTranslating
        var contentRequests = [TranslationSession.Request]()
        var titleRequests = [TranslationSession.Request]()
        for (index, article) in articles.enumerated() {
            if let content = article.content,
                article.contentTranslated == nil
            {
                contentRequests.append(
                    TranslationSession.Request(
                        sourceText: content,
                        clientIdentifier: "\(index)")
                )
            }
            if let title = article.title,
                article.titleTranslated == nil
            {
                titleRequests.append(
                    TranslationSession.Request(
                        sourceText: title,
                        clientIdentifier: "\(index)")
                )
            }
        }
        do {
            if !contentRequests.isEmpty {
                for try await response in translateSession.translate(batch: contentRequests) {
                    guard let index = Int(response.clientIdentifier ?? "") else {
                        continue
                    }
                    articles[index].contentTranslated = response.targetText
                }
            }
            if !titleRequests.isEmpty {
                for try await response in translateSession.translate(batch: titleRequests) {
                    guard let index = Int(response.clientIdentifier ?? "") else {
                        continue
                    }
                    articles[index].titleTranslated = response.targetText
                }
            }
            guard !articles.compactMap(\.contentTranslated).isEmpty,
                !articles.compactMap(\.titleTranslated).isEmpty
            else {
                return updateStateTopHeadlines(state: .emptyTranslate)
            }
            showArticlesTranslations(show: true)
        } catch {
            updateStateTopHeadlines(
                error: error as? LocalizedError,
                state: .emptyTranslate
            )
        }
    }

    @MainActor
    func loadWebPage() {
        if let url = URL(string: "https://gnews.io"),
            !showNoNetworkConnection,
            showWebView,
            webPage == nil
        {
            webPage = WebPage()
            webPage?.load(URLRequest(url: url))
        }
    }

    @MainActor
    func reset() async {
        do {
            try deleteTopHeadlinesUseCase.delete()
            articles.removeAll()
            countries.removeAll()
            selectedApiKey = ""
            selectedCategory = .general
            readCountries()
            selectedCountry = ""
            state = .emptyRead
            translate = false
            translateDisabled = true
            webPage = nil
        } catch {
            showAlert(error: Errors.reset)
        }
    }

    func sensoryFeedback(_ feedback: SensoryFeedback) {
        sensoryFeedback = feedback
        sensoryFeedbackBool.toggle()
    }

    func showCategoriesTip() {
        CategoriesTip.show = true
    }

    func showSettingsTip() {
        SettingsTip.show = true
    }

    @MainActor
    func checkCategoriesTipStatusUpdate() async {
        for await statusUpdate in categoriesTip.statusUpdates {
            switch statusUpdate {
            case .invalidated(.tipClosed):
                showSettingsTip()
            default:
                break
            }
        }
    }

    @MainActor
    private func checkNetworkConnection() async -> Bool? {
        for await path in NWPathMonitor() {
            if path.status == .unsatisfied {
                showAlert(error: Errors.noNetworkConnection)
                showNoNetworkConnection = true
                return false
            } else {
                showNoNetworkConnection = false
                return true
            }
        }
        return nil
    }

    private func configureTipKit() {
        guard
            let tipsConfigurationOptions: [Tips.ConfigurationOption] = try? [
                .displayFrequency(.immediate),
                .datastoreLocation(.groupContainer(identifier: "com.burakerol.BobbysNews")),
            ]
        else {
            return
        }
        #if DEBUG
            CommandLine.arguments.contains("-Testing")
                ? Tips.hideAllTipsForTesting() : try? Tips.configure(tipsConfigurationOptions)
        #else
            try? Tips.configure(tipsConfigurationOptions)
        #endif
    }

    private func readCountries() {
        countries = Locale.Region.isoRegions
            .compactMap {
                $0.subRegions.isEmpty ? $0.identifier.lowercased() : nil
            }
    }

    private func readTopHeadlines() {
        if !selectedApiKey.isEmpty,
            !selectedCountry.isEmpty
        {
            do {
                guard
                    let articles = try readTopHeadlinesUseCase.read(
                        category: selectedCategory.rawValue,
                        country: selectedCountry
                    ).articles
                else {
                    throw Errors.read
                }
                self.articles = articles
                translateDisabled = articles.isEmpty
                updateStateTopHeadlines(
                    state: articles.isEmpty
                        ? state == .emptyFetch ? .emptyFetch : .emptyRead : .loaded
                )
            } catch {
                updateStateTopHeadlines(
                    error: error as? LocalizedError,
                    state: .emptyRead
                )
            }
        }
    }

    private func showAlert(error: LocalizedError) {
        if let errorDescription = error.errorDescription,
            let recoverySuggestion = error.recoverySuggestion
        {
            alertError = .custom(
                errorDescription,
                recoverySuggestion
            )
        } else {
            alertError = .error(error.localizedDescription)
        }
        showAlert = true
    }

    private func showArticlesTranslations(show: Bool) {
        sensoryFeedback(.success)
        for index in articles.indices {
            articles[index].showTranslations = show
        }
        updateStateTopHeadlines(
            state: articles.isEmpty ? state == .emptyFetch ? .emptyFetch : .emptyRead : .loaded
        )
    }

    private func updateStateTopHeadlines(
        error: LocalizedError? = nil,
        state: States
    ) {
        self.state = state
        if let error {
            showAlert(error: error)
        }
    }
}
