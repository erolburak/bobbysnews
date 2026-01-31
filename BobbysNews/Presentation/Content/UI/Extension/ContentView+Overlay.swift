//
//  ContentView+Overlay.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.06.25.
//

import SwiftUI

extension ContentView {
    // MARK: - Layouts

    func Overlay() -> some View {
        Group {
            if apiKey.isEmpty,
                viewModel.articles.isEmpty
            {
                ContentUnavailableView {
                    Label(
                        "EmptyApiKey",
                        systemImage: "key"
                    )
                    .accessibilityIdentifier(Accessibility.emptyApiKey.id)
                } description: {
                    Text("EmptyApiKeyMessage")
                } actions: {
                    Button("Add") {
                        viewModel.showEditAlert = true
                        viewModel.sensoryFeedbackTrigger(feedback: .press(.button))
                    }
                    .buttonStyle(.glass)
                    .font(
                        .system(
                            .subheadline,
                            weight: .bold
                        )
                    )
                    .textCase(.uppercase)
                }
            } else if country.isEmpty {
                ContentUnavailableView {
                    Label(
                        "EmptyCountry",
                        systemImage: "flag"
                    )
                    .accessibilityIdentifier(Accessibility.emptyCountry.id)
                } description: {
                    Text("EmptyCountryMessage")
                }
            } else {
                switch viewModel.state {
                case .isLoading, .isTranslating:
                    Text(
                        viewModel.state == .isLoading
                            ? "TopHeadlinesLoading" : "TopHeadlinesTranslating"
                    )
                    .font(
                        .system(
                            .headline,
                            weight: .black
                        )
                    )
                case .loaded:
                    EmptyView()
                case .emptyFetch, .emptyRead:
                    ContentUnavailableView {
                        Label(
                            viewModel.state == .emptyFetch
                                ? "EmptyFetchTopHeadlines" : "EmptyReadTopHeadlines",
                            systemImage: "newspaper"
                        )
                    } description: {
                        Text(
                            viewModel.state == .emptyFetch
                                ? "EmptyFetchTopHeadlinesMessage" : "EmptyReadTopHeadlinesMessage"
                        )
                    } actions: {
                        Button("Refresh") {
                            Task {
                                await viewModel.fetchTopHeadlines(
                                    state: .isLoading,
                                    sensoryFeedback: true
                                )
                            }
                        }
                        .buttonStyle(.glass)
                        .font(
                            .system(
                                .subheadline,
                                weight: .bold
                            )
                        )
                        .textCase(.uppercase)
                    }
                case .emptyTranslate:
                    ContentUnavailableView {
                        Label(
                            "EmptyTranslateTopHeadlines",
                            systemImage: "translate"
                        )
                    } description: {
                        Text("EmptyTranslateTopHeadlinesMessage")
                    } actions: {
                        Button("Disable") {
                            viewModel.translate = false
                        }
                        .buttonStyle(.glass)
                        .font(
                            .system(
                                .subheadline,
                                weight: .bold
                            )
                        )
                        .textCase(.uppercase)
                    }
                }
            }
        }
        .symbolEffect(
            .bounce,
            options: .nonRepeating
        )
        .symbolVariant(.fill)
    }
}
