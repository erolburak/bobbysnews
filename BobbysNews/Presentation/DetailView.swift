//
//  DetailView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import SwiftUI
import WebKit

struct DetailView: View {

	// MARK: - Properties

	@State var viewModel: DetailViewModel

	// MARK: - Layouts

	var body: some View {
		ScrollView {
			VStack {
				Text(viewModel.article.source?.name ?? String(localized: "EmptyArticleSource"))
					.font(.system(.subheadline,
								  weight: .black))
					.lineLimit(1)

				Text(viewModel.article.publishedAt?.toRelative ?? String(localized: "EmptyArticlePublishedAt"))
					.font(.system(size: 8,
								  weight: .semibold))

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

					/// Workaround to left align the content
					Color.clear.frame(height: 0)
				}
				.padding(.horizontal)

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
					}
					.foregroundStyle(.secondary)
					.padding(.horizontal)
					.padding(.top, 40)
				}
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.textSelection(.enabled)
		.toolbar {
			if let url = viewModel.article.url {
				ToolbarItem(placement: .primaryAction) {
					ShareLink(item: url)
						.labelStyle(.iconOnly)
				}
			}
		}
		.sheet(isPresented: $viewModel.showWebView) {
			if let url = viewModel.article.url {
				NavigationStack {
					WebView(url: url)
						.ignoresSafeArea(edges: .bottom)
						.toolbar {
							ToolbarItem(placement: .principal) {
								Text("Headline")
							}

							ToolbarItem(placement: .primaryAction) {
								Button {
									viewModel.showWebView = false
								} label: {
									Image(systemName: "xmark")
								}
							}
						}
				}
			}
		}
	}

	private func EmptyImageView() -> some View {
		Image(systemName: "photo")
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(height: 24)
			.foregroundStyle(.gray)
	}

	private struct WebView: UIViewRepresentable {

		// MARK: - Properties

		let url: URL

		// MARK: - Actions

		func makeUIView(context: Context) -> WKWebView {
			WKWebView()
		}

		func updateUIView(_ webView: WKWebView,
						  context: Context) {
			webView.load(URLRequest(url: url))
		}
	}
}

#Preview {
	DetailView(viewModel: ViewModelDI().detailViewModel(article: Article(author: "Author",
																		 content: "ContentStart\n\n\n\n\n\n\n\n\n\n\n\n\n\nContentEnd",
																		 country: "Country",
																		 publishedAt: "2001-02-03T12:34:56Z".toDate,
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
