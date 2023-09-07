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
				if case viewModel.stateTopHeadlines = .loaded {
					ForEach(viewModel.articles ?? []) { article in
						NavigationLink(value: article) {
							Text(article.publishedAt?.toRelative ?? "") +
							Text(article.source?.name ?? "")
						}
					}
					.navigationDestination(for: Article.self) { article in
						DetailView(viewModel: ViewModelDI.shared.detailViewModel(article: article))
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
						Menu(!country.isEmpty ? country : String(localized: "CountrySelect")) {
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
								await viewModel.fetchSources(state: .isLoading)
							}
						}
					case .emptyFetch:
						Text("EmptyFetchSources")
					case .emptyRead:
						Text("EmptyReadSources")
					}
				}

				ToolbarItem(placement: .bottomBar) {
					Picker(selection: $viewModel.selectedApiKey) {
						ForEach(viewModel.apiKeys,
								id: \.self) { item in
							Text(item.keyDescription)
						}
					} label: {
						EmptyView()
					}
				}
			}
		}
		.overlay(alignment: .center) {
			if viewModel.selectedCountry == nil {
				Text("EmptySelectedCountry")
			} else {
				switch viewModel.stateTopHeadlines {
				case .isInitialLoading, .isLoading:
					ProgressView()
				case .loaded:
					EmptyView()
				case .emptyFetch:
					Text("EmptyFetch")
				case .emptyRead:
					Text("EmptyRead")
				}
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
			if newState == nil {
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
