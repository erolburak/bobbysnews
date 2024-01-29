//
//  DetailView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import SwiftUI
import WebKit

struct DetailView: View {

	// MARK: - Properties

	@State var viewModel: DetailViewModel

	// MARK: - Layouts

	var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				VStack {
					Text(viewModel.title)
						.font(.system(.subheadline,
									  weight: .black))
						.lineLimit(1)

					Text(viewModel.article.publishedAt?.toRelative ?? String(localized: "EmptyArticlePublishedAt"))
						.font(.system(size: 8,
									  weight: .semibold))
				}
				.frame(maxWidth: .infinity)
				.multilineTextAlignment(.center)
				.id(0)

				GeometryReader { geometry in
					AsyncImage(url: viewModel.article.urlToImage) { phase in
						if let image = phase.image {
							image
								.resizable()
								.scaledToFill()
								.frame(width: geometry.size.width,
									   height: 280,
									   alignment: .center)
								.clipped()
						} else if case .empty = phase {
							EmptyImageView()
						} else if phase.error != nil {
							EmptyImageView()
						}
					}
					.frame(width: geometry.size.width,
						   height: 280)
				}
				.frame(height: 280)
				.background(.bar)
				.clipShape(UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 40,
																					topTrailing: 40)))
				.overlay {
					LinearGradient(gradient: Gradient(colors: [.clear,
															   Color(uiColor: .systemBackground)]),
								   startPoint: UnitPoint(x: 0.5, y: 0.9),
								   endPoint: UnitPoint(x: 0.5, y: 1))
				}
				.id(1)

				VStack(alignment: .leading,
					   spacing: 8) {
					Text(viewModel.article.title ?? String(localized: "EmptyArticleTitle"))
						.font(.system(.headline,
									  weight: .black))
					
					Text(viewModel.article.content ?? String(localized: "EmptyArticleContent"))
						.font(.callout)
						.padding(.top, 8)

					Text(viewModel.article.author ?? String(localized: "EmptyArticleAuthor"))
						.font(.system(size: 8,
									  weight: .semibold))
				}
				.padding(.horizontal)
				.id(2)

				if viewModel.article.url != nil {
					VStack {
						Text("OpenWebView")
							.font(.system(.caption2,
										  weight: .semibold))

						Button {
							viewModel.showWebView = true
						} label: {
							Text("Read")
								.textCase(.uppercase)
						}
						.font(.system(.subheadline,
									  weight: .black))
						.accessibilityIdentifier("ReadButton")
					}
					.frame(maxWidth: .infinity)
					.textSelection(.disabled)
					.foregroundStyle(.secondary)
					.padding(.horizontal)
					.padding(.top, 40)
					.id(3)
				}
			}
		}
		.navigationTitle(viewModel.navigationTitle)
		.navigationBarTitleDisplayMode(.inline)
		.scrollPosition(id: $viewModel.scrollPosition,
						anchor: .top)
		.scrollTargetLayout()
		.textSelection(.enabled)
		.toolbar {
			if let url = viewModel.article.url {
				ToolbarItem(placement: .primaryAction) {
					ShareLink(item: url)
						.accessibilityIdentifier("ShareLink")
				}
			}
		}
		.sheet(isPresented: $viewModel.showWebView) {
			if let url = viewModel.article.url {
				NavigationStack {
					WebView(isLoading: $viewModel.webViewIsLoading,
							url: url)
					.navigationTitle("Headline")
					.navigationBarTitleDisplayMode(.inline)
					.ignoresSafeArea(edges: .bottom)
					.toolbar {
						ToolbarItem(placement: .cancellationAction) {
							Button {
								viewModel.showWebView = false
							} label: {
								Image(systemName: "xmark.circle.fill")
							}
							.accessibilityIdentifier("CloseButton")
						}
					}
					.overlay {
						if viewModel.webViewIsLoading {
							ProgressView()
						}
					}
				}
			}
		}
	}

	private func EmptyImageView() -> some View {
		Image(systemName: "photo.circle.fill")
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(height: 24)
			.foregroundStyle(.gray)
	}

	private struct WebView: UIViewRepresentable {

		// MARK: - Properties

		@Binding var isLoading: Bool
		let url: URL

		// MARK: - Actions

		func makeCoordinator() -> Coordinator {
			Coordinator(parent: self)
		}
	
		func makeUIView(context: Context) -> WKWebView {
			let wkWebView = WKWebView()
			wkWebView.navigationDelegate = context.coordinator
			wkWebView.load(URLRequest(url: url))
			return wkWebView
		}

		func updateUIView(_ webView: WKWebView,
						  context: Context) {}

		// MARK: - Coordinator

		class Coordinator: NSObject,
						   WKNavigationDelegate {

			// MARK: - Private Properties

			private let parent: WebView

			// MARK: - Inits

			init(parent: WebView) {
				self.parent = parent
			}

			// MARK: - Actions

			func webView(_ webView: WKWebView,
						 didStartProvisionalNavigation navigation: WKNavigation!) {
				parent.isLoading = true
			}

			func webView(_ webView: WKWebView,
						 didFinish navigation: WKNavigation!) {
				parent.isLoading = false
			}
		}
	}
}

#Preview {
	NavigationStack {
		DetailView(viewModel: ViewModelFactory().detailViewModel(article: Article(author: "Author",
																			 content: "ContentStart\n\n\n\n\n\n\n\n\n\n\n\n\n\nContentEnd",
																			 country: "Country",
																			 publishedAt: .now,
																			 source: Source(category: "SourceCategory",
																							country: "SourceCountry",
																							id: "SourceId",
																							language: "SourceLanguage",
																							name: "SourceName",
																							story: "SourceStory",
																							url: URL(string: "https://github.com/erolburak/bobbysnews")),
																			 story: "Story",
																			 title: "Title",
																			 url: URL(string: "https://github.com/erolburak/bobbysnews"),
																			 urlToImage: URL(string: "https://raw.githubusercontent.com/erolburak/bobbysnews/main/BobbysNews/Resource/Assets.xcassets/AppIcon.appiconset/%E2%80%8EAppIcon.png"))))
	}
}
