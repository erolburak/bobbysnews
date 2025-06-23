//
//  DetailView+Sheet.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.06.25.
//

import SwiftUI
import WebKit

extension DetailView {
    // MARK: - Layouts

    func Sheet() -> some View {
        NavigationStack {
            Group {
                if viewModel.showNoNetworkConnection {
                    ContentUnavailableView(
                        "ErrorDescriptionNoNetworkConnection",
                        systemImage: "network.slash",
                        description: Text("ErrorRecoverySuggestionNoNetworkConnection")
                    )
                    .symbolEffect(
                        .bounce,
                        options: .nonRepeating
                    )
                    .symbolVariant(.fill)
                } else if viewModel.webPage?.isLoading == true {
                    ProgressView()
                } else if let webPage = viewModel.webPage {
                    WebView(webPage)
                }
            }
            .navigationTitle("Headline")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close) {
                        viewModel.showWebView = false
                        viewModel.sensoryFeedbackBool.toggle()
                    }
                    .accessibilityIdentifier("CloseWebViewButton")
                }
            }
        }
        .task {
            viewModel.loadWebPage()
        }
    }
}
