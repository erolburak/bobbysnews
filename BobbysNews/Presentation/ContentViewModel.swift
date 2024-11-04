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

@Observable
final class ContentViewModel {
    // MARK: - Type Definitions

    enum StateSources {
        /// General States
        case isLoading, loaded
        /// Empty States
        case emptyFetch, emptyRead
    }

    enum StateTopHeadlines {
        /// General States
        case isLoading, loaded, isTranslating
        /// Empty States
        case emptyFetch, emptyRead, emptyTranslate
    }

    struct SettingsTip: Tip {
        // MARK: - Properties

        @Parameter
        static var show: Bool = false
        var image: Image? = Image(systemName: "gearshape.circle.fill")
        var message: Text? = Text("SettingsTipMessage")
        var rules: [Rule] {
            [#Rule(Self.$show) {
                $0
            }]
        }

        var title = Text("Settings")
    }

    // MARK: - Use Cases

    /// Sources
    private let deleteSourcesUseCase: PDeleteSourcesUseCase
    private let fetchSourcesUseCase: PFetchSourcesUseCase
    private let readSourcesUseCase: PReadSourcesUseCase
    /// TopHeadlines
    private let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
    private let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
    private let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase

    // MARK: - Properties

    let apiKeyTotalAmount = 5
    let settingsTip = SettingsTip()
    var alertError: Errors?
    var apiKeyVersion = 1 {
        didSet {
            sensoryFeedbackTrigger(feedback: .selection)
        }
    }

    var articles: [Article] = []
    var countries: [String] = []
    var listDisabled: Bool { stateTopHeadlines != .loaded }
    var listOpacity: Double { stateTopHeadlines == .loaded ? 1 : 0.3 }
    var selectedCountry = "" {
        willSet {
            if !newValue.isEmpty {
                sensoryFeedbackTrigger(feedback: .selection)
            }
        }
    }

    var sensoryFeedback: SensoryFeedback?
    var sensoryFeedbackBool = false
    var showAlert = false
    var showConfirmationDialog = false
    var stateSources: StateSources = .isLoading
    var stateTopHeadlines: StateTopHeadlines = .isLoading
    var translate = false
    var translateDisabled = true
    var translationSessionConfiguration: TranslationSession.Configuration?

    // MARK: - Lifecycles

    init(deleteSourcesUseCase: PDeleteSourcesUseCase,
         fetchSourcesUseCase: PFetchSourcesUseCase,
         readSourcesUseCase: PReadSourcesUseCase,
         deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase,
         fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase,
         readTopHeadlinesUseCase: PReadTopHeadlinesUseCase)
    {
        self.deleteSourcesUseCase = deleteSourcesUseCase
        self.fetchSourcesUseCase = fetchSourcesUseCase
        self.readSourcesUseCase = readSourcesUseCase
        self.deleteTopHeadlinesUseCase = deleteTopHeadlinesUseCase
        self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
        self.readTopHeadlinesUseCase = readTopHeadlinesUseCase
        configureTipKit()
    }

    // MARK: - Methods

    @MainActor
    func onAppear(selectedCountry: String) async {
        self.selectedCountry = selectedCountry
        readSources()
        readTopHeadlines()
        await fetchSources()
    }

    @MainActor
    func fetchSources(sensoryFeedback: Bool? = nil) async {
        if sensoryFeedback == true {
            sensoryFeedbackTrigger(feedback: .success)
        }
        stateSources = .isLoading
        do {
            if await checkNetworkConnection() == true {
                try await fetchSourcesUseCase.fetch(apiKey: apiKeyVersion)
            }
            readSources()
        } catch {
            updateStateSources(error: error,
                               state: countries.isEmpty ? .emptyFetch : .loaded)
        }
    }

    @MainActor
    func fetchTopHeadlines(state: StateTopHeadlines? = nil,
                           sensoryFeedback: Bool? = nil) async
    {
        if sensoryFeedback == true {
            sensoryFeedbackTrigger(feedback: .success)
        }
        if !selectedCountry.isEmpty {
            if let state {
                stateTopHeadlines = state
            }
            do {
                if await checkNetworkConnection() == true {
                    try await fetchTopHeadlinesUseCase.fetch(apiKey: apiKeyVersion,
                                                             country: selectedCountry)
                }
                translate = false
                readTopHeadlines()
            } catch {
                updateStateTopHeadlines(error: error,
                                        state: articles.isEmpty ? .emptyFetch : .loaded)
            }
        }
    }

    @MainActor
    func reset() async {
        do {
            /// Delete all persisted sources
            try deleteSourcesUseCase.delete()
            /// Delete all persisted topHeadlines
            try deleteTopHeadlinesUseCase.delete()
            apiKeyVersion = 1
            articles.removeAll()
            countries.removeAll()
            selectedCountry = ""
            stateSources = .emptyRead
            stateTopHeadlines = .emptyRead
            translate = false
            translateDisabled = true
            await MainActor.run {
                sensoryFeedbackTrigger(feedback: .success)
            }
        } catch {
            await MainActor.run {
                showAlert(error: .reset)
            }
        }
    }

    func showSettingsTip() throws {
        SettingsTip.show = true
    }

    @MainActor
    func translate(translateSession: TranslationSession) async {
        stateTopHeadlines = .isTranslating
        var contentRequests: [TranslationSession.Request]? = []
        var titleRequests: [TranslationSession.Request]? = []
        for (index, article) in articles.enumerated() {
            if let content = article.content {
                contentRequests?.append(TranslationSession.Request(sourceText: content,
                                                                   clientIdentifier: "\(index)"))
            }
            if let title = article.title {
                titleRequests?.append(TranslationSession.Request(sourceText: title,
                                                                 clientIdentifier: "\(index)"))
            }
        }
        do {
            if let contentRequests,
               !contentRequests.isEmpty
            {
                for try await response in translateSession.translate(batch: contentRequests) {
                    guard let index = Int(response.clientIdentifier ?? "") else {
                        continue
                    }
                    articles[index].contentTranslated = response.targetText
                }
            }
            if let titleRequests,
               !titleRequests.isEmpty
            {
                for try await response in translateSession.translate(batch: titleRequests) {
                    guard let index = Int(response.clientIdentifier ?? "") else {
                        continue
                    }
                    articles[index].titleTranslated = response.targetText
                }
            }
            updateStateTopHeadlines(state: contentRequests?.isEmpty == true && titleRequests?.isEmpty == true ? .emptyTranslate : .loaded)
        } catch {
            updateStateTopHeadlines(error: error,
                                    state: .emptyTranslate)
        }
    }

    @MainActor
    func translateConfiguration() async {
        guard await checkNetworkConnection() == true else {
            translate = false
            return
        }
        if translate, translationSessionConfiguration == nil {
            translationSessionConfiguration = TranslationSession.Configuration()
        } else if translate {
            translationSessionConfiguration?.invalidate()
        } else {
            readTopHeadlines()
        }
        sensoryFeedbackTrigger(feedback: .success)
    }

    private func configureTipKit() {
        try? Tips.configure([.displayFrequency(.immediate),
                             .datastoreLocation(.groupContainer(identifier: "com.burakerol.BobbysNews"))])
    }

    @MainActor
    private func checkNetworkConnection() async -> Bool? {
        for await path in NWPathMonitor() {
            if path.status == .unsatisfied {
                showAlert(error: .noNetworkConnection)
                return false
            } else {
                return true
            }
        }
        return nil
    }

    private func readSources() {
        do {
            guard let sources = try readSourcesUseCase.read().sources else {
                throw Errors.read
            }
            /// Set of unique countries
            let countries = Set(sources.compactMap { $0.country == "zh" ? "cn" : $0.country })
                .sorted(by: { lhs, rhs in
                    Locale.current.localizedString(forRegionCode: lhs) ?? "" <= Locale.current.localizedString(forRegionCode: rhs) ?? ""
                })
            self.countries = countries
            updateStateSources(state: countries.isEmpty ? stateSources == .emptyFetch ? .emptyFetch : .emptyRead : .loaded)
        } catch {
            updateStateSources(error: error,
                               state: .emptyRead)
        }
    }

    private func readTopHeadlines() {
        do {
            guard let articles = try readTopHeadlinesUseCase.read(country: selectedCountry).articles else {
                throw Errors.read
            }
            self.articles = articles
            translateDisabled = articles.isEmpty
            updateStateTopHeadlines(state: articles.isEmpty ? stateTopHeadlines == .emptyFetch ? .emptyFetch : .emptyRead : .loaded)
        } catch {
            updateStateTopHeadlines(error: error,
                                    state: .emptyRead)
        }
    }

    private func sensoryFeedbackTrigger(feedback: SensoryFeedback) {
        sensoryFeedback = feedback
        sensoryFeedbackBool.toggle()
    }

    private func showAlert(error: Errors) {
        alertError = error
        showAlert = true
        sensoryFeedbackTrigger(feedback: .error)
    }

    private func updateStateSources(error: Error? = nil,
                                    state: StateSources)
    {
        stateSources = state
        if let error {
            showAlert(error: error as? Errors ?? .error(error.localizedDescription))
        }
    }

    private func updateStateTopHeadlines(error: Error? = nil,
                                         state: StateTopHeadlines)
    {
        stateTopHeadlines = state
        if let error {
            showAlert(error: error as? Errors ?? .error(error.localizedDescription))
        }
    }
}
