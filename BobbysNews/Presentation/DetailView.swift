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
                Group {
                    Text(viewModel.title)
                        .font(.system(.subheadline,
                                      weight: .black))
                        .lineLimit(1)
                        .onGeometryChange(for: CGFloat.self) { geometryProxy in
                            geometryProxy.frame(in: .scrollView(axis: .vertical)).minY
                        } action: { newValue in
                            viewModel.titleScrollOffset = newValue
                        }

                    Text(viewModel.article.publishedAt?.toRelative ?? String(localized: "EmptyArticlePublishedAt"))
                        .font(.system(size: 8,
                                      weight: .semibold))
                }
                .frame(maxWidth: .infinity,
                       alignment: .center)
                .onGeometryChange(for: CGFloat.self) { geometryProxy in
                    geometryProxy.size.height
                } action: { newValue in
                    viewModel.titleHeight = newValue
                }

                Group {
                    if let image = viewModel.articleImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .containerRelativeFrame(.horizontal)
                    } else if let urlToImage = viewModel.article.urlToImage {
                        AsyncImage(url: urlToImage,
                                   transaction: Transaction(animation: .easeIn(duration: 0.75)))
                        { asyncImagePhase in
                            if let image = asyncImagePhase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .containerRelativeFrame(.horizontal)
                            } else {
                                ProgressView()
                            }
                        }
                    } else {
                        Image(systemName: "photo.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 32)
                            .foregroundStyle(.gray)
                            .symbolEffect(.bounce,
                                          options: .nonRepeating)
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
                       spacing: 8)
                {
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
                        .font(.system(.subheadline,
                                      weight: .black))
                        .lineLimit(1)

                    Text(viewModel.article.publishedAt?.toRelative ?? String(localized: "EmptyArticlePublishedAt"))
                        .font(.system(size: 8,
                                      weight: .semibold))
                }
                .opacity(viewModel.navigationTitleOpacity)
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
                        switch viewModel.stateWebView {
                        case .isLoading, .loaded:
                            WebView(stateWebView: $viewModel.stateWebView,
                                    url: url)
                        case .error, .noNetworkConnection:
                            ContentUnavailableView(viewModel.stateWebView == .error ? "ErrorWebView" : "ErrorDescriptionNoNetworkConnection",
                                                   systemImage: viewModel.stateWebView == .error ? "newspaper.circle.fill" : "network.slash",
                                                   description: Text(viewModel.stateWebView == .error ? "ErrorWebViewMessage" : "ErrorRecoverySuggestionNoNetworkConnection"))
                                .symbolEffect(.bounce,
                                              options: .nonRepeating)
                        }
                    }
                    .navigationTitle("Headline")
                    .navigationBarTitleDisplayMode(.inline)
                    .ignoresSafeArea(edges: .bottom)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close",
                                   systemImage: "xmark.circle.fill")
                            {
                                viewModel.showWebView = false
                            }
                            .accessibilityIdentifier("CloseButton")
                        }
                    }
                    .overlay {
                        if viewModel.stateWebView == .isLoading {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview("DetailView") {
    NavigationStack {
        DetailView(viewModel: ViewModelFactory.shared.detailViewModel(article: PreviewMock.article,
                                                                      articleImage: nil))
    }
}

private struct WebView: UIViewRepresentable {
    // MARK: - Properties

    @Binding var stateWebView: DetailViewModel.StatesWebView
    let url: URL

    // MARK: - Methods

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.load(URLRequest(url: url))
        return wkWebView
    }

    func updateUIView(_: WKWebView,
                      context _: Context) {}

    // MARK: - Coordinator

    class Coordinator: NSObject,
        WKNavigationDelegate
    {
        // MARK: - Private Properties

        private let parent: WebView

        // MARK: - Lifecycles

        init(parent: WebView) {
            self.parent = parent
        }

        // MARK: - Methods

        func webView(_: WKWebView,
                     didStartProvisionalNavigation _: WKNavigation!)
        {
            parent.stateWebView = .isLoading
        }

        func webView(_: WKWebView,
                     didFail _: WKNavigation!,
                     withError _: any Error)
        {
            parent.stateWebView = .error
        }

        func webView(_: WKWebView,
                     didFinish _: WKNavigation!)
        {
            parent.stateWebView = .loaded
        }
    }
}

#Preview("WebView") {
    if let url = URL(string: "https://github.com/erolburak/bobbysnews") {
        WebView(stateWebView: .constant(.loaded),
                url: url)
    }
}
