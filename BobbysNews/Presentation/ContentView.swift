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
				ScrollViewReader { proxy in
					ForEach(viewModel.articles ?? []) { article in
						NavigationLink(value: article) {
							Item(article: article)
						}
						.contextMenu {
							if let url = article.url {
								ShareLink("Share", item: url)
							}
						}
						.id(article)
						.accessibilityIdentifier(article == viewModel.articles?.first ? "NavigationLinkItem" : "")
					}
					.navigationDestination(for: Article.self) { article in
						DetailView(viewModel: ViewModelDI.shared.detailViewModel(article: article))
					}
					.onChange(of: viewModel.stateTopHeadlines) { _, newState in
						if newState == .loaded {
							proxy.scrollTo(viewModel.articles?.first)
						}
					}
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
										await viewModel.fetchSources()
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
								if UIDevice.current.userInterfaceIdiom == .pad {
									viewModel.showConfirmationDialogPad = true
								} else {
									viewModel.showConfirmationDialogPhone = true
								}
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
			VStack {
				if viewModel.selectedCountry == nil {
					ContentUnavailableView {
						Label("EmptySelectedCountry",
							  systemImage: "flag.slash")
					} description: {
						Text("EmptySelectedCountryMessage")
					}
				} else {
					switch viewModel.stateTopHeadlines {
					case .isLoading:
						Text("TopHeadlinesLoading")
							.fontWeight(.black)
					case .loaded:
						EmptyView()
					case .emptyFetch:
						ContentUnavailableView {
							Label("EmptyFetchTopHeadlines",
								  systemImage: "newspaper")
						} description: {
							Text("EmptyFetchTopHeadlinesMessage")
						}

						RefreshButton()
					case .emptyRead:
						ContentUnavailableView {
							Label("EmptyReadTopHeadlines",
								  systemImage: "newspaper")
						} description: {
							Text("EmptyReadTopHeadlinesMessage")
						}

						RefreshButton()
					}
				}
			}
		}
		.confirmationDialog("ResetConfirmationDialog",
							isPresented: $viewModel.showConfirmationDialogPhone,
							titleVisibility: .visible) {
			ResetButton()
		}
		.alert("Reset", isPresented: $viewModel.showConfirmationDialogPad) {
			ResetButton()
		} message: {
			Text("ResetConfirmationDialog")
		}
		.alert(isPresented: $viewModel.showAlert,
			   error: viewModel.alertError) { _ in
		} message: { error in
			if let message = error.recoverySuggestion {
				Text(message)
			}
		}
		.onAppear {
			viewModel.onAppear()
		}
		.onDisappear() {
			viewModel.onDisappear()
		}
		.onChange(of: country,
				  initial: true) {
			viewModel.selectedCountry = !country.isEmpty ? country : nil
			if !country.isEmpty {
				Task.detached(priority: .background) {
					await viewModel.fetchTopHeadlines()
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

	private func RefreshButton() -> some View {
		Button {
			Task {
				await viewModel.fetchTopHeadlines()
			}
		} label: {
			Text("Refresh")
				.textCase(.uppercase)
		}
		.font(.system(.subheadline,
					  weight: .black))
		.foregroundStyle(.secondary)
		.accessibilityIdentifier("RefreshButton")
	}

	private func ResetButton() -> some View {
		Button("Reset", role: .destructive) {
			country = ""
			viewModel.reset()
		}
		.accessibilityIdentifier("ResetConfirmationDialogButton")
	}
}

#Preview {
	ContentView(viewModel: ViewModelDI.shared.contentViewModel())
}
