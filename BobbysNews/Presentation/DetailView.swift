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
				Text(viewModel.title)
					.font(.system(.subheadline,
								  weight: .black))
					.lineLimit(1)
					.frame(maxWidth: .infinity,
						   alignment: .center)
					.onGeometryChange(for: CGFloat.self) { geometryProxy in
						geometryProxy.frame(in: .scrollView(axis: .vertical)).minY
					} action: { newValue in
						viewModel.titleScrollOffset = newValue
					}

				Text(viewModel.article.publishedAt?.toRelative ?? String(localized: "EmptyArticlePublishedAt"))
					.font(.system(size: 8,
								  weight: .semibold))
					.frame(maxWidth: .infinity,
						   alignment: .center)

				AsyncImage(url: viewModel.article.urlToImage) { phase in
					if let image = phase.image {
						image
							.resizable()
							.scaledToFill()
							.frame(width: .infinity,
								   height: 280,
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
				.frame(maxWidth: .infinity,
					   idealHeight: 280)
				.background(.bar)
				.clipShape(.rect(topLeadingRadius: 40,
								 topTrailingRadius: 40))
				.overlay {
					LinearGradient(gradient: Gradient(colors: [.clear,
															   Color(uiColor: .systemBackground)]),
								   startPoint: UnitPoint(x: 0.5, y: 0.9),
								   endPoint: UnitPoint(x: 0.5, y: 1))
				}

				VStack(alignment: .leading,
					   spacing: 8) {
					Text(viewModel.articleTitle)
						.font(.system(.headline,
									  weight: .black))

					Text(viewModel.articleContent)
						.font(.callout)
						.padding(.top, 8)

					Text(viewModel.article.author ?? String(localized: "EmptyArticleAuthor"))
						.font(.system(size: 8,
									  weight: .semibold))
				}
				.padding(.horizontal)

				if viewModel.article.url != nil {
					VStack {
						Text("OpenWebView")
							.font(.system(.caption2,
										  weight: .semibold))

						Button("Read") {
							viewModel.showWebView = true
						}
						.textCase(.uppercase)
						.font(.system(.subheadline,
									  weight: .black))
						.accessibilityIdentifier("ReadButton")
					}
					.frame(maxWidth: .infinity)
					.textSelection(.disabled)
					.foregroundStyle(.secondary)
					.padding(.horizontal)
					.padding(.top, 40)
				}
			}
		}
		.textSelection(.enabled)
		.toolbar {
			ToolbarItem(placement: .principal) {
				VStack {
					Text(viewModel.title)
						.font(.headline)

					Text(viewModel.article.publishedAt?.toRelative ?? String(localized: "EmptyArticlePublishedAt"))
						.font(.system(size: 8,
									  weight: .semibold))
				}
				.offset(y: viewModel.navigationTitleScrollOffset)
				.onGeometryChange(for: CGFloat.self) { geometryProxy in
					geometryProxy.size.height + 8
				} action: { newValue in
					viewModel.navigationTitleOffset = newValue
				}
			}

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
					Group {
						if !viewModel.webViewShowError {
							WebView(isLoading: $viewModel.webViewIsLoading,
									showError: $viewModel.webViewShowError,
									url: url)
						} else {
							ContentUnavailableView("ErrorWebView",
												   systemImage: "newspaper.circle.fill",
												   description: Text("ErrorWebViewMessage"))
						}
					}
					.navigationTitle("Headline")
					.navigationBarTitleDisplayMode(.inline)
					.ignoresSafeArea(edges: .bottom)
					.toolbar {
						ToolbarItem(placement: .cancellationAction) {
							Button("Close",
								   systemImage: "xmark.circle.fill") {
								viewModel.showWebView = false
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
}

#Preview("DetailView") {
	NavigationStack {
		DetailView(viewModel: ViewModelFactory.shared.detailViewModel(article: PreviewMock.article))
	}
}

private struct WebView: UIViewRepresentable {

	// MARK: - Properties

	@Binding var isLoading: Bool
	@Binding var showError: Bool
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

	func updateUIView(_ uiView: WKWebView,
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
					 didFail navigation: WKNavigation!,
					 withError error: any Error) {
			parent.showError = true
		}

		func webView(_ webView: WKWebView,
					 didFinish navigation: WKNavigation!) {
			parent.isLoading = false
		}
	}
}

#Preview("WebView") {
	if let url = URL(string: "https://github.com/erolburak/bobbysnews") {
		WebView(isLoading: .constant(false),
				showError: .constant(false),
				url: url)
	}
}
