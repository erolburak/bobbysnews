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
    // MARK: - Properties

    @AppStorage("apiKey") var apiKey = ""
    @AppStorage("category") var category: Categories = .general
    @AppStorage("country") var country = ""
    @State var viewModel: ContentViewModel

    // MARK: - Layouts

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach($viewModel.articles) {
                    ContentListItem(article: $0) { feedback in
                        viewModel.sensoryFeedback(feedback)
                    }
                }
            }
            .disabled(viewModel.listDisabled)
            .opacity(viewModel.listOpacity)
            .refreshable {
                await viewModel.fetchTopHeadlines()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationSubtitle("\(viewModel.articles.count)Articles")
            .toolbarTitleMenu {
                ToolbarTitleMenu()
            }
            .toolbar {
                Toolbar()
            }
            .sheet(isPresented: $viewModel.showWebView) {
                Sheet()
            }
        }
        .overlay(alignment: .center) {
            Overlay()
        }
        .alert(
            isPresented: $viewModel.showAlert,
            error: viewModel.alertError
        ) { _ in
        } message: {
            if let message = $0.recoverySuggestion {
                Text(message)
            }
        }
        .task {
            viewModel.onAppear(
                selectedApiKey: apiKey,
                selectedCategory: category,
                selectedCountry: country
            )
        }
        .task {
            await viewModel.checkCategoriesTipStatusUpdate()
        }
        .onChange(of: viewModel.selectedCategory) { _, newValue in
            viewModel.sensoryFeedback(.selection)
            category = newValue
            viewModel.articles.removeAll()

            Task {
                await viewModel.fetchTopHeadlines(state: .isLoading)
            }
        }
        .onChange(of: viewModel.selectedCountry) { _, newValue in
            if !newValue.isEmpty {
                viewModel.sensoryFeedback(.selection)
            }
            country = newValue
            viewModel.articles.removeAll()
            Task {
                await viewModel.fetchTopHeadlines(state: .isLoading)
            }
        }
        .onChange(of: viewModel.showAlert) { _, newValue in
            newValue ? viewModel.sensoryFeedback(.error) : viewModel.sensoryFeedback(.impact)
        }
        .onChange(of: viewModel.showEditAlert) {
            viewModel.sensoryFeedback(.impact)
        }
        .onChange(of: viewModel.showNoNetworkConnection) { _, newValue in
            newValue ? viewModel.sensoryFeedback(.error) : viewModel.sensoryFeedback(.impact)
        }
        .onChange(of: viewModel.showResetConfirmationDialog) {
            viewModel.sensoryFeedback(.impact)
        }
        .onChange(of: viewModel.showWebView) {
            viewModel.sensoryFeedback(.impact)
        }
        .onChange(of: viewModel.translate) {
            viewModel.sensoryFeedback(.impact)
            Task {
                await viewModel.configureTranslations()
            }
        }
        .sensoryFeedback(trigger: viewModel.sensoryFeedbackBool) {
            viewModel.sensoryFeedback
        }
        .translationTask(viewModel.translationSessionConfiguration) {
            await viewModel.fetchTranslations(translateSession: $0)
        }
    }
}

#Preview("ContentView") {
    ContentView(viewModel: ViewModelFactory.shared.contentViewModel())
}
