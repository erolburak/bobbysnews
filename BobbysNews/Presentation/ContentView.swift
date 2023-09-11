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

	@AppStorage("country") private var country = "us"

	// MARK: - Layouts

    var body: some View {
		NavigationStack {
			ScrollView {
				ForEach(viewModel.articles ?? []) { article in
					NavigationLink(value: article) {
						Item(article: article)
					}
					.contextMenu {
						if let url = article.url {
							ShareLink("Share", item: url)
						}
					}
					.accessibilityIdentifier(article == viewModel.articles?.first ? "NavigationLinkItem" : "")
				}
				.navigationDestination(for: Article.self) { article in
					DetailView(viewModel: ViewModelDI.shared.detailViewModel(article: article))
				}
				.opacity(viewModel.stateTopHeadlines == .loaded ? 1 : 0)
				.animation(.easeInOut,
						   value: viewModel.stateTopHeadlines)
			}
			.navigationTitle("TopHeadlines")
			.toolbarTitleDisplayMode(.inline)
			.refreshable {
				await viewModel.fetchTopHeadlines(state: .isLoading)
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Menu {
						switch viewModel.stateSources {
						case .isLoading:
							Text("CountriesLoading")
						case .loaded:
							if let countries = viewModel.countries {
								Picker("CountrySelection",
									   selection: $country) {
									ForEach(countries,
											id: \.self) { country in
										Text(Locale.current.localizedString(forRegionCode: country) ?? "")
											.tag(country)
											.accessibilityIdentifier("CountryPickerItem" + country)
									}
								}
								.pickerStyle(.menu)
							}
						case .emptyFetch, .emptyRead:
							Section(viewModel.stateSources == .emptyFetch ? "EmptyFetchSources" : "EmptyReadSources") {
								Button {
									Task {
										await viewModel.fetchSources(state: .isLoading)
									}
								} label: {
									Label("CountriesLoad", systemImage: "arrow.down.to.line")
										.labelStyle(.titleAndIcon)
								}
							}
						}

						Section {
							Picker("ApiKeySelection",
								   selection: $viewModel.apiKeyVersion) {
								ForEach(1...viewModel.apiKeyTotalAmount,
										id: \.self) { version in
									Text("ApiKey\(version)")
										.accessibilityIdentifier("ApiKeyPickerItem\(version)")
								}
							}
							.pickerStyle(.menu)
							.menuActionDismissBehavior(.disabled)
							.accessibilityIdentifier("ApiKeyPicker")
						}

						Section {
							Button(role: .destructive) {
								viewModel.showResetDialog = true
							} label: {
								Label("Reset", systemImage: "trash")
									.labelStyle(.titleAndIcon)
							}
							.accessibilityIdentifier("ResetButton")
						}
					} label: {
						Image(systemName: "gearshape")
							.accessibilityIdentifier("SettingsImage")
					}
				}
			}
		}
		.overlay(alignment: .center) {
			if viewModel.selectedCountry == nil {
				EmptyStateView(image: "flag.slash",
							   title: "EmptySelectedCountry",
							   message: "EmptySelectedCountryMessage")
			} else {
				switch viewModel.stateTopHeadlines {
				case .isLoading:
					Text("TopHeadlinesLoading")
						.fontWeight(.black)
				case .loaded:
					EmptyView()
				case .emptyFetch:
					EmptyStateView(image: "newspaper",
								   title: "EmptyFetchTopHeadlines",
								   message: "EmptyFetchTopHeadlinesMessage")
				case .emptyRead:
					EmptyStateView(image: "newspaper",
								   title: "EmptyReadTopHeadlines",
								   message: "EmptyReadTopHeadlinesMessage")
				}
			}
		}
		.confirmationDialog("ResetConfirmation",
							isPresented: $viewModel.showResetDialog,
							titleVisibility: .visible) {
			Button("Reset", role: .destructive) {
				viewModel.reset()
			}
			.accessibilityIdentifier("ResetConfirmationButton")
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

			AsyncImage(url: article.urlToImage) { phase in
				if let image = phase.image {
					image
						.resizable()
						.scaledToFill()
						.frame(width: 80,
							   height: 80,
							   alignment: .center)
						.clipped()
				} else if case .empty = phase {
					EmptyImageView()
				} else if phase.error != nil {
					EmptyImageView()
				}
			}
			.frame(width: 80,
				   height: 80)
			.background(.bar)
			.clipShape(RoundedRectangle(cornerRadius: 12))
		}
		.padding(.horizontal)
		.padding(.vertical, 20)
	}

	private func EmptyImageView() -> some View {
		Image(systemName: "photo")
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(height: 24)
			.foregroundStyle(.gray)
	}

	private func EmptyStateView(image: String,
								title: LocalizedStringKey,
								message: LocalizedStringKey) -> some View {
		VStack {
			Image(systemName: image)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(height: 32)
				.padding(.bottom, 4)

			Text(title)
				.font(.system(.title3,
							  weight: .black))

			Text(message)
				.font(.system(.footnote,
							  weight: .regular))
		}
		.multilineTextAlignment(.center)
		.padding()
	}
}

#Preview {
	ContentView(viewModel: ViewModelDI.shared.contentViewModel())
}
