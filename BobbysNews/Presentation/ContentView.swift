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
			ScrollView {
				if viewModel.stateTopHeadlines == .loaded {
					ForEach(viewModel.articles ?? []) { article in
						NavigationLink(value: article) {
							Item(article: article)
						}
						.contextMenu {
							if let url = article.url {
								ShareLink("Share", item: url)
							}
						}
					}
					.navigationDestination(for: Article.self) { article in
						DetailView(viewModel: ViewModelDI.shared.detailViewModel(article: article))
					}
				}
			}
			.navigationTitle(viewModel.stateTopHeadlines == .loaded ? "TopHeadlines" : "")
			.refreshable {
				await viewModel.fetchTopHeadlines()
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Menu {
						switch viewModel.stateSources {
						case .isInitialLoading, .isLoading:
							ProgressView()
						case .load, .loaded:
							if viewModel.countries?.isEmpty == true {
								Button {
									Task {
										await viewModel.fetchSources(state: .isLoading)
									}
								} label: {
									Label("CountryLoad", systemImage: "arrow.down.to.line")
										.labelStyle(.titleAndIcon)
								}
								.menuActionDismissBehavior(.disabled)
							} else if let countries = viewModel.countries {
								Menu("CountrySelect") {
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

						Button(role: .destructive) {
							viewModel.showResetDialog = true
						} label: {
							Label("Reset", systemImage: "trash")
								.labelStyle(.titleAndIcon)
						}
					} label: {
						Image(systemName: "gearshape")
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
		.confirmationDialog("ResetConfirmation",
							isPresented: $viewModel.showResetDialog,
							titleVisibility: .visible) {
			Button("Reset", role: .destructive) {
				viewModel.reset()
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

	private func Item(article: Article) -> some View {
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

				Text(article.title ?? String(localized: "EmptyArticleTitle"))
					.font(.system(.subheadline,
								  weight: .semibold))
					.lineLimit(2)
			}
			.multilineTextAlignment(.leading)

			Spacer()

			if let urlToImage = article.urlToImage {
				AsyncImage(url: urlToImage) { phase in
					if let image = phase.image {
						image
							.resizable()
							.scaledToFill()
							.frame(width: 80,
								   height: 80,
								   alignment: .center)
							.clipped()
					} else if phase.error != nil {
						Image(systemName: "photo")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(height: 24)
							.foregroundStyle(.gray)
					} else {
						ProgressView()
					}
				}
				.frame(width: 80,
					   height: 80)
				.background(.bar)
				.clipShape(RoundedRectangle(cornerRadius: 12))
			}
		}
		.padding(.horizontal)
		.padding(.vertical, 20)
	}
}

#Preview {
	ContentView(viewModel: ViewModelDI.shared.contentViewModel())
}
