//
//  ContentView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import SwiftUI
import Translation

struct ContentView: View {
    // MARK: - Private Properties

    @AppStorage("apiKey") private var apiKey = ""
    @AppStorage("category") private var category: Categories = .general
    @AppStorage("country") private var country = ""

    // MARK: - Properties

    @State var viewModel: ContentViewModel

    // MARK: - Layouts

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach($viewModel.articles) {
                    ListItem(article: $0)
                }
            }
            .navigationTitle("TopHeadlines")
            .toolbarTitleDisplayMode(.inline)
            .disabled(viewModel.listDisabled)
            .opacity(viewModel.listOpacity)
            .refreshable {
                await viewModel.fetchTopHeadlines()
            }
            .toolbar {
                Toolbar()
            }
        }
        .overlay(alignment: .center) {
            Overlay()
        }
        .alert(isPresented: $viewModel.showAlert,
               error: viewModel.alertError)
        { _ in
        } message: {
            if let message = $0.recoverySuggestion {
                Text(message)
            }
        }
        .task {
            viewModel.onAppear(selectedApiKey: apiKey,
                               selectedCategory: category,
                               selectedCountry: country)
        }
        .onChange(of: viewModel.selectedCountry) { _, newValue in
            country = newValue
            viewModel.articles.removeAll()

            Task {
                await viewModel.fetchTopHeadlines(state: .isLoading)
            }
        }
        .onChange(of: viewModel.selectedCategory) { _, newValue in
            category = newValue
            viewModel.articles.removeAll()

            Task {
                await viewModel.fetchTopHeadlines(state: .isLoading)
            }
        }
        .sensoryFeedback(trigger: viewModel.sensoryFeedbackBool) { _, _ in
            viewModel.sensoryFeedback
        }
        .onChange(of: viewModel.translate) {
            Task {
                await viewModel.configureTranslations()
            }
        }
        .translationTask(viewModel.translationSessionConfiguration) {
            await viewModel.fetchTranslations(translateSession: $0)
        }
    }

    private func Overlay() -> some View {
        Group {
            if apiKey.isEmpty,
               viewModel.articles.isEmpty
            {
                ContentUnavailableView {
                    Label("EmptySelectedApiKey",
                          systemImage: "key")
                } description: {
                    Text("EmptySelectedApiKeyMessage")
                        .accessibilityIdentifier("EmptySelectedApiKeyMessage")
                }
            } else if country.isEmpty {
                ContentUnavailableView {
                    Label("EmptySelectedCountry",
                          systemImage: "flag")
                } description: {
                    Text("EmptySelectedCountryMessage")
                        .accessibilityIdentifier("EmptySelectedCountryMessage")
                }
            } else {
                switch viewModel.state {
                case .isLoading, .isTranslating:
                    Text(viewModel.state == .isLoading ? "TopHeadlinesLoading" : "TopHeadlinesTranslating")
                        .fontWeight(.black)
                case .loaded:
                    EmptyView()
                case .emptyFetch, .emptyRead:
                    ContentUnavailableView {
                        Label(viewModel.state == .emptyFetch ? "EmptyFetchTopHeadlines" : "EmptyReadTopHeadlines",
                              systemImage: "newspaper")
                    } description: {
                        Text(viewModel.state == .emptyFetch ? "EmptyFetchTopHeadlinesMessage" : "EmptyReadTopHeadlinesMessage")
                    } actions: {
                        Button("Refresh") {
                            Task {
                                await viewModel.fetchTopHeadlines(state: .isLoading,
                                                                  sensoryFeedback: true)
                            }
                        }
                        .textCase(.uppercase)
                        .font(.system(.subheadline,
                                      weight: .black))
                    }
                case .emptyTranslate:
                    ContentUnavailableView {
                        Label("EmptyTranslateTopHeadlines",
                              systemImage: "translate")
                    } description: {
                        Text("EmptyTranslateTopHeadlinesMessage")
                    } actions: {
                        Button("Disable") {
                            viewModel.translate = false
                        }
                        .textCase(.uppercase)
                        .font(.system(.subheadline,
                                      weight: .black))
                    }
                }
            }
        }
        .symbolEffect(.bounce,
                      options: .nonRepeating)
    }

    private func Toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                Section("ApiKey") {
                    Label(viewModel.selectedApiKey.isEmpty ? String(localized: "ApiKeyPlaceholder") : viewModel.selectedApiKey,
                          systemImage: "key")

                    Button(viewModel.selectedApiKey.isEmpty ? "Add" : "Edit",
                           systemImage: viewModel.selectedApiKey.isEmpty ? "plus" : "pencil")
                    {
                        viewModel.showEditAlert = true
                    }
                    .accessibilityIdentifier("ApiKeyAddEditButton")
                }

                Section("CountrySelection") {
                    Picker(Locale.current.localizedString(forRegionCode: viewModel.selectedCountry) ?? "-",
                           systemImage: "flag",
                           selection: $viewModel.selectedCountry)
                    {
                        ForEach(viewModel.countriesSorted,
                                id: \.self)
                        {
                            Text(Locale.current.localizedString(forRegionCode: $0) ?? "")
                                .tag($0)
                                .accessibilityIdentifier("CountryPickerItem")
                        }
                    }
                    .accessibilityIdentifier("CountryPicker")
                    .pickerStyle(.menu)
                }

                Section("CategorySelection") {
                    Picker(viewModel.selectedCategory.localized,
                           systemImage: "tag",
                           selection: $viewModel.selectedCategory)
                    {
                        ForEach(viewModel.categoriesSorted,
                                id: \.self)
                        {
                            Text($0.localized)
                                .tag($0.localized)
                                .accessibilityIdentifier("CategoryPickerItem")
                        }
                    }
                    .accessibilityIdentifier("CategoryPicker")
                    .pickerStyle(.menu)
                }

                Section {
                    Toggle("Translate",
                           systemImage: "translate",
                           isOn: $viewModel.translate)
                        .disabled(viewModel.translateDisabled)
                        .accessibilityIdentifier("TranslateToggle")
                }

                Section {
                    Button("Reset",
                           systemImage: "trash",
                           role: .destructive)
                    {
                        viewModel.showConfirmationDialog = true
                    }
                    .accessibilityIdentifier("ResetButton")
                }
            } label: {
                Image(systemName: "gearshape")
                    .popoverTip(viewModel.settingsTip,
                                arrowEdge: .bottom)
                    .onAppear {
                        Task {
                            try await Task.sleep(for: .seconds(1))
                            try viewModel.showSettingsTip()
                        }
                    }
                    .accessibilityIdentifier("SettingsImage")
            }
            .alert("ApiKey",
                   isPresented: $viewModel.showEditAlert)
            {
                TextField("ApiKeyPlaceholder",
                          text: $viewModel.selectedApiKey)

                Button("Cancel",
                       role: .cancel) {}

                Button("Done") {
                    apiKey = viewModel.selectedApiKey

                    Task {
                        await viewModel.fetchTopHeadlines(state: .isLoading)
                        viewModel.sensoryFeedbackTrigger(feedback: .success)
                    }
                }
                .accessibilityIdentifier("ApiKeyDoneButton")
            }
            .confirmationDialog("ResetConfirmationDialog",
                                isPresented: $viewModel.showConfirmationDialog,
                                titleVisibility: .visible)
            {
                Button("Reset",
                       role: .destructive)
                {
                    Task {
                        await viewModel.reset()
                        apiKey = ""
                    }
                }
                .accessibilityIdentifier("ResetConfirmationDialogButton")
            }
        }
    }
}

#Preview("ContentView") {
    ContentView(viewModel: ViewModelFactory.shared.contentViewModel())
}

private struct ListItem: View {
    // MARK: - Private Properties

    @Namespace private var animation
    @State private var articleImage: Image?
    @State private var showTranslationPresentation = false
    @State private var translationPresentationText = ""

    // MARK: - Properties

    @Binding var article: Article

    // MARK: - Layouts

    var body: some View {
        NavigationLink {
            DetailView(viewModel: ViewModelFactory.shared.detailViewModel(article: article,
                                                                          articleImage: articleImage))
                .navigationTransition(.zoom(sourceID: article.id,
                                            in: animation))
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(article.source?.name ?? String(localized: "EmptyArticleSource"))
                        .font(.system(.subheadline,
                                      weight: .black))
                        .lineLimit(1)

                    Text(article.publishedAt?.toRelative ?? String(localized: "EmptyArticlePublishedAt"))
                        .font(.system(size: 8,
                                      weight: .semibold))

                    Spacer()

                    Text((article.showTranslations ? article.titleTranslated : article.title) ?? String(localized: "EmptyArticleTitle"))
                        .font(.system(.subheadline,
                                      weight: .semibold))
                        .lineLimit(2)
                }
                .multilineTextAlignment(.leading)

                Spacer()

                AsyncImage(url: article.image,
                           transaction: Transaction(animation: .easeIn(duration: 0.75)))
                {
                    switch $0 {
                    case let .success(image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80,
                                   height: 80,
                                   alignment: .center)
                            .clipped()
                            .onAppear {
                                articleImage = image
                            }
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                            .foregroundStyle(.gray)
                            .symbolEffect(.bounce,
                                          options: .nonRepeating)
                    default:
                        ProgressView()
                    }
                }
                .frame(width: 80,
                       height: 80)
                .background(.bar)
                .clipShape(.rect(cornerRadius: 12))
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .contentShape(.rect)
            .contextMenu {
                if let url = article.url {
                    ShareLink("Share",
                              item: url)
                        .environment(\.symbolVariants,
                                     .none)
                }
                if let title = article.title {
                    Button("Translate",
                           systemImage: "translate")
                    {
                        translationPresentationText = title
                        showTranslationPresentation = true
                    }
                }
            }
            .translationPresentation(isPresented: $showTranslationPresentation,
                                     text: translationPresentationText)
        }
        .matchedTransitionSource(id: article.id,
                                 in: animation)
        .accessibilityIdentifier("NavigationLink")
    }
}

#Preview("ListItem") {
    ListItem(article: .constant(PreviewMock.article))
}
