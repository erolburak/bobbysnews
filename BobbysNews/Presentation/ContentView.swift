//
//  ContentView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import SwiftUI

struct ContentView: View {

	// MARK: - Properties

	@State var viewModel: ContentViewModel

	// MARK: - Private Properties

	@AppStorage("country") private var country = ""

	// MARK: - Layouts

    var body: some View {
		NavigationStack {
			ScrollView(.vertical,
					   showsIndicators: false) {
				if !viewModel.selectedCountry.isEmpty {
					switch viewModel.stateTopHeadlines {
					case .isInitialLoading, .isLoading:
						ProgressView()
					case .loaded:
						ForEach(viewModel.articles ?? []) { article in
							NavigationLink(value: article) {
								Text(article.publishedAt?.toRelative ?? "") +
								Text(article.source?.name ?? "")
							}
						}
						.navigationDestination(for: Article.self) { article in
							DetailView(viewModel: ViewModelDI.shared.detailViewModel(article: article))
						}
					case .emptyFetch:
						Text("EmptyFetch")
					case .emptyRead:
						Text("EmptyRead")
					}
				}
			}
			.refreshable {
				await viewModel.fetchTopHeadlines()
			}
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button("Delete") {
						viewModel.delete()
					}
				}

				ToolbarItem(placement: .topBarTrailing) {
					switch viewModel.stateSources {
					case .isInitialLoading, .isLoading:
						ProgressView()
					case .loaded:
						Menu("CountrySelect") {
							if let countries = viewModel.countries {
								ForEach(countries,
										id: \.self) { item in
									Button(item) {
										country = item
									}
								}
							}
						}
					case .load:
						Button("CountryLoad") {
							Task {
								await viewModel.fetchTopHeadlinesSources(state: .isLoading)
							}
						}
					case .emptyFetch:
						Text("EmptyFetchSources")
					case .emptyRead:
						Text("EmptyReadSources")
					}
				}
			}
		}
		.overlay {
			if viewModel.selectedCountry.isEmpty {
				Text("EmptySelectedCountry")
			}
		}
		.alert(isPresented: $viewModel.showAlert,
			   error: viewModel.alertError) { _ in
		} message: { error in
			if let message = error.recoverySuggestion {
				Text(message)
			}
		}
		.onAppear {
			viewModel.onAppear(country: country)
		}
		.onDisappear() {
			viewModel.onDisappear()
		}
		.onChange(of: viewModel.selectedCountry) { _, newState in
			if newState.isEmpty {
				country = ""
			}
		}
		.onChange(of: country) {
			viewModel.selectedCountry = country

			Task {
				await viewModel.fetchTopHeadlines(state: .isLoading)
			}
		}
    }
}

#Preview {
	ContentView(viewModel: ViewModelDI.shared.contentViewModel())
}
