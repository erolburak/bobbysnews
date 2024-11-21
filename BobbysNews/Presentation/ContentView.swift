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

    @AppStorage("country") private var country = ""

    // MARK: - Properties

    @State var viewModel: ContentViewModel

    // MARK: - Layouts

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach($viewModel.articles) { $article in
                    ListItem(article: $article)
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
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        switch viewModel.stateSources {
                        case .isLoading:
                            Text("CountriesLoading")
                        case .loaded:
                            if !viewModel.countries.isEmpty {
                                Picker(selection: $viewModel.selectedCountry) {
                                    ForEach(viewModel.countries,
                                            id: \.self)
                                    { country in
                                        Text(Locale.current.localizedString(forRegionCode: country) ?? "")
                                            .tag(country)
                                            .accessibilityIdentifier("CountryPickerItem" + country)
                                    }
                                } label: {
                                    Label("CountrySelection",
                                          systemImage: "flag.circle.fill")
                                }
                                .pickerStyle(.menu)
                            }
                        case .emptyFetch, .emptyRead:
                            Section(viewModel.stateSources == .emptyFetch ? "EmptyFetchSources" : "EmptyReadSources") {
                                Button("CountriesLoad",
                                       systemImage: "arrow.down.to.line.circle.fill")
                                {
                                    Task {
                                        await viewModel.fetchSources(sensoryFeedback: true)
                                    }
                                }
                            }
                            .menuActionDismissBehavior(.disabled)
                        }

                        Section {
                            Toggle("Translate",
                                   systemImage: "translate",
                                   isOn: $viewModel.translate)
                                .disabled(viewModel.translateDisabled)
                                .accessibilityIdentifier("TranslateToggle")
                        }

                        Section {
                            Picker(selection: $viewModel.apiKeyVersion) {
                                ForEach(1 ... viewModel.apiKeyTotalAmount,
                                        id: \.self)
                                { version in
                                    Text("ApiKey\(version)")
                                        .accessibilityIdentifier("ApiKeyPickerItem\(version)")
                                }
                            } label: {
                                Label("ApiKeySelection",
                                      systemImage: "key.fill")
                            }
                            .pickerStyle(.menu)
                            .accessibilityIdentifier("ApiKeyPicker")
                        }

                        Section {
                            Button("Reset",
                                   systemImage: "trash.circle.fill",
                                   role: .destructive)
                            {
                                viewModel.showConfirmationDialog = true
                            }
                            .accessibilityIdentifier("ResetButton")
                        }
                    } label: {
                        Image(systemName: "gearshape.circle.fill")
                            .popoverTip(viewModel.settingsTip,
                                        arrowEdge: .top)
                            .onAppear {
                                Task {
                                    try await Task.sleep(for: .seconds(1))
                                    try viewModel.showSettingsTip()
                                }
                            }
                            .accessibilityIdentifier("SettingsImage")
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
                            }
                        }
                        .accessibilityIdentifier("ResetConfirmationDialogButton")
                    }
                }
            }
        }
        .overlay(alignment: .center) {
            Group {
                if viewModel.selectedCountry.isEmpty {
                    ContentUnavailableView {
                        Label("EmptySelectedCountry",
                              systemImage: "flag.circle.fill")
                    } description: {
                        Text("EmptySelectedCountryMessage")
                            .accessibilityIdentifier("EmptySelectedCountryMessage")
                    }
                } else {
                    switch viewModel.stateTopHeadlines {
                    case .isLoading, .isTranslating:
                        Text(viewModel.stateTopHeadlines == .isLoading ? "TopHeadlinesLoading" : "TopHeadlinesTranslating")
                            .fontWeight(.black)
                    case .loaded:
                        EmptyView()
                    case .emptyFetch, .emptyRead:
                        ContentUnavailableView {
                            Label(viewModel.stateTopHeadlines == .emptyFetch ? "EmptyFetchTopHeadlines" : "EmptyReadTopHeadlines",
                                  systemImage: "newspaper.circle.fill")
                        } description: {
                            Text(viewModel.stateTopHeadlines == .emptyFetch ? "EmptyFetchTopHeadlinesMessage" : "EmptyReadTopHeadlinesMessage")
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
                            .foregroundStyle(.secondary)
                            .accessibilityIdentifier("RefreshButton")
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
                            .foregroundStyle(.secondary)
                            .accessibilityIdentifier("DisableButton")
                        }
                    }
                }
            }
            .symbolEffect(.bounce,
                          options: .nonRepeating)
        }
        .alert(isPresented: $viewModel.showAlert,
               error: viewModel.alertError)
        { _ in
        } message: { error in
            if let message = error.recoverySuggestion {
                Text(message)
            }
        }
        .task {
            await viewModel.onAppear(selectedCountry: country)
        }
        .onChange(of: viewModel.selectedCountry) { _, newValue in
            country = newValue
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
        .translationTask(viewModel.translationSessionConfiguration) { translateSession in
            await viewModel.fetchTranslations(translateSession: translateSession)
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

                Group {
                    if let urlToImage = article.urlToImage {
                        AsyncImage(url: urlToImage,
                                   transaction: Transaction(animation: .easeIn(duration: 0.75)))
                        { asyncImagePhase in
                            if let image = asyncImagePhase.image {
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
                            } else {
                                ProgressView()
                            }
                        }
                    } else {
                        Image(systemName: "photo.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                            .foregroundStyle(.gray)
                            .symbolEffect(.bounce,
                                          options: .nonRepeating)
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
                        .accessibilityIdentifier("ShareLink")
                }
                if let title = article.title {
                    Button("Translate",
                           systemImage: "translate")
                    {
                        translationPresentationText = title
                        showTranslationPresentation = true
                    }
                    .accessibilityIdentifier("TranslateButton")
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
