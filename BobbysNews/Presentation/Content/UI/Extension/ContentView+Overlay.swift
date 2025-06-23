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
                } description: {
                    Text("EmptyApiKeyMessage")
                        .accessibilityIdentifier("EmptyApiKeyMessage")
                }
            } else if country.isEmpty {
                ContentUnavailableView {
                    Label(
                        "EmptyCountry",
                        systemImage: "flag"
                    )
                } description: {
                    Text("EmptyCountryMessage")
                        .accessibilityIdentifier("EmptyCountryMessage")
                }
            } else {
                switch viewModel.state {
                case .isLoading, .isTranslating:
                    Text(
                        viewModel.state == .isLoading
                            ? "TopHeadlinesLoading" : "TopHeadlinesTranslating"
                    )
                    .font(.headline)
                    .fontWeight(.black)
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
                        .font(.subheadline)
                        .fontWeight(.bold)
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
                        .font(.subheadline)
                        .fontWeight(.bold)
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
