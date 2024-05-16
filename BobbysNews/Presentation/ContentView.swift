//
//  ContentView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import SwiftUI

struct ContentView: View {

	// MARK: - Private Properties

	@AppStorage("country") private var country = ""

	// MARK: - Properties

	@State var viewModel: ContentViewModel

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
					.accessibilityIdentifier(article.id == viewModel.articles?.first?.id ? "NavigationLinkItem" : "")
				}
				.navigationDestination(for: Article.self) { article in
					DetailView(viewModel: ViewModelFactory.shared.detailViewModel(article: article))
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
								Picker(selection: $viewModel.selectedCountry) {
									ForEach(countries,
											id: \.self) { country in
										Text(Locale.current.localizedString(forRegionCode: country) ?? "")
											.tag(country)
											.accessibilityIdentifier("CountryPickerItem" + country)
									}
								} label: {
									Label("CountrySelection",
										  systemImage: "flag.circle.fill")
								}
								.pickerStyle(.menu)
							}
						case .emptyFetch, .emptyRead:
							Section(viewModel.stateSources == .emptyFetch ? "EmptyFetchSources" : "EmptyReadSources") {
								Button("CountriesLoad",
									   systemImage: "arrow.down.to.line.circle.fill") {
									Task {
										await viewModel.fetchSources(sensoryFeedback: true)
									}
								}
							}
						}

						Section {
							Picker(selection: $viewModel.apiKeyVersion) {
								ForEach(1...viewModel.apiKeyTotalAmount,
										id: \.self) { version in
									Text("ApiKey\(version)")
										.accessibilityIdentifier("ApiKeyPickerItem\(version)")
								}
							} label: {
								Label("ApiKeySelection",
									  systemImage: "key.fill")
							}
							.pickerStyle(.menu)
							.menuActionDismissBehavior(.disabled)
							.accessibilityIdentifier("ApiKeyPicker")
						}

						Section {
							Button("Reset",
								   systemImage: "trash.circle.fill",
								   role: .destructive) {
								viewModel.showConfirmationDialog = true
							}
							.accessibilityIdentifier("ResetButton")
						}
					} label: {
						Image(systemName: "gearshape.circle.fill")
							.popoverTip(viewModel.settingsTip,
										arrowEdge: .top)
							.accessibilityIdentifier("SettingsImage")
					}
					.onTapGesture {
						viewModel.invalidateSettingsTip()
					}
					.confirmationDialog("ResetConfirmationDialog",
										isPresented: $viewModel.showConfirmationDialog,
										titleVisibility: .visible) {
						Button("Reset",
							   role: .destructive) {
							viewModel.reset()
						}
						.accessibilityIdentifier("ResetConfirmationDialogButton")
					}
				}
			}
		}
		.overlay(alignment: .center) {
			if viewModel.selectedCountry.isEmpty {
				ContentUnavailableView("EmptySelectedCountry",
									   systemImage: "flag.circle.fill",
									   description: Text("EmptySelectedCountryMessage"))
			} else {
				switch viewModel.stateTopHeadlines {
				case .isLoading:
					Text("TopHeadlinesLoading")
						.fontWeight(.black)
				case .loaded:
					EmptyView()
				case .emptyFetch, .emptyRead:
					ContentUnavailableView {
						Label(viewModel.stateTopHeadlines == .emptyFetch ? "EmptyFetchTopHeadlines" : "EmptyReadTopHeadlines",
							  systemImage: "newspaper.circle.fill")
					} description: {
						Text(viewModel.stateTopHeadlines == .emptyFetch ? "EmptyFetchTopHeadlinesMessage" : "EmptyReadTopHeadlinesMessage")
					} actions: {
						Button("Refresh") {
							Task {
								await viewModel.fetchTopHeadlines(state: .isLoading)
							}
						}
						.textCase(.uppercase)
						.font(.system(.subheadline,
									  weight: .black))
						.foregroundStyle(.secondary)
						.accessibilityIdentifier("RefreshButton")
					}
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
		.task {
			viewModel.onAppear(selectedCountry: country)
			await viewModel.fetchSources()
		}
		.onDisappear() {
			viewModel.onDisappear()
		}
		.onChange(of: viewModel.selectedCountry) { _, newValue in
			country = newValue
			viewModel.articles?.removeAll()
			Task {
				await viewModel.fetchTopHeadlines(state: .isLoading)
			}
		}
		.sensoryFeedback(trigger: viewModel.sensoryFeedbackBool) { _, _ in
			viewModel.sensoryFeedback
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
				} else {
					Image(systemName: "photo.circle.fill")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(height: 24)
						.foregroundStyle(.gray)
				}
			}
			.frame(width: 80,
				   height: 80)
			.background(.bar)
			.clipShape(.rect(cornerRadius: 12))
		}
		.padding(.horizontal)
		.padding(.vertical, 20)
	}
}

#Preview {
	ContentView(viewModel: ViewModelFactory.shared.contentViewModel())
}
