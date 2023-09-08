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
	@State private var show = false

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
						.contextMenu {
							// TODO: Add Share
						} preview: {
							// TODO: Preview Website or DetailView
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
				ToolbarItem(placement: .topBarTrailing) {
					Menu {
						switch viewModel.stateSources {
						case .isInitialLoading, .isLoading:
							ProgressView()
						case .load, .loaded:
							if viewModel.countries?.isEmpty == true {
								Button("CountryLoad") {
									Task {
										await viewModel.fetchSources(state: .isLoading)
									}
								}
							} else {
								Menu("CountrySelect") {
									if let countries = viewModel.countries {
										Picker(selection: $country) {
											ForEach(countries.values.sorted(by: <),
													id: \.self) { value in
												Text(value)
													.tag(countries.first { $0.value == value }?.key )
											}
										} label: {
											EmptyView()
										}
									}
								}
							}
						case .emptyFetch:
							Text("EmptyFetchSources")
						case .emptyRead:
							Text("EmptyReadSources")
						}

						Menu("ApiKeySelect") {
							Picker(selection: $viewModel.apiKeyVersion) {
								ForEach(1...viewModel.apiKeyTotalAmount,
										id: \.self) { version in
									Text("ApiKey\(version)")
								}
							} label: {
								EmptyView()
							}
						}

						Button("Delete") {
							viewModel.showDeleteDialog = true
						}
					} label: {
						Image(systemName: "gear")
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
		.confirmationDialog("DeleteConfirmation",
							isPresented: $viewModel.showDeleteDialog,
							titleVisibility: .visible) {
			Button("Delete",
				   role: .destructive) {
				viewModel.delete()
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
			if !country.isEmpty {
				viewModel.selectedCountry = country

				Task {
					await viewModel.fetchTopHeadlines(state: .isLoading)
				}
			}
		}
		.onChange(of: viewModel.apiKeyVersion) {
			viewModel.stateSources = .load
			viewModel.stateSources = .loaded
		}
    }
}

#Preview {
	ContentView(viewModel: ViewModelDI.shared.contentViewModel())
}
