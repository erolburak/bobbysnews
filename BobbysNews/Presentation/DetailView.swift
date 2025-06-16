//
//  DetailView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import SwiftUI
import WebKit

struct DetailView: View {
    // MARK: - Private Properties

    @Environment(\.dismiss) private var dismiss

    // MARK: - Properties

    @State var viewModel: DetailViewModel

    // MARK: - Layouts

    var body: some View {
        ScrollView {
            Group {
                if let image = viewModel.articleImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxHeight: 500,
                               alignment: .center)
                        .clipped()
                } else {
                    AsyncImage(url: viewModel.article.image,
                               transaction: Transaction(animation: .easeIn(duration: 0.75)))
                    {
                        switch $0 {
                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxHeight: 500,
                                       alignment: .center)
                                .clipped()
                        case .failure:
                            Spacer()

                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 32)
                                .foregroundStyle(.gray)
                                .symbolEffect(.bounce,
                                              options: .nonRepeating)
                                .frame(alignment: .center)

                            Spacer()
                        default:
                            Spacer()

                            ProgressView()

                            Spacer()
                        }
                    }
                }
            }
            .visualEffect { emptyVisualEffect, geometryProxy in
                let geometryProxyHeight = geometryProxy.size.height
                let geometryProxyMinY = geometryProxy.frame(in: .scrollView).minY
                let scaleFactor = (geometryProxyHeight + max(0, geometryProxyMinY)) / geometryProxyHeight
                return emptyVisualEffect.scaleEffect(scaleFactor,
                                                     anchor: .bottom)
            }
            .frame(maxWidth: .infinity,
                   minHeight: 500,
                   maxHeight: 500)
            .overlay(alignment: .bottom) {
                LinearGradient(stops: [Gradient.Stop(color: .clear,
                                                     location: 0.6),
                                       Gradient.Stop(color: Color(uiColor: .systemBackground).opacity(0.8),
                                                     location: 0.8),
                                       Gradient.Stop(color: Color(uiColor: .systemBackground),
                                                     location: 1)],
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()
            }

            VStack(alignment: .leading) {
                Text(viewModel.articleTitle)
                    .font(.title)
                    .fontWeight(.black)
                    .padding(.bottom)

                Text(viewModel.articleContent)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .padding(.top, -120)
            .padding([.horizontal,
                      .bottom])

            Button("GoToArticle") {
                viewModel.showWebView = true
                viewModel.sensoryFeedbackBool.toggle()
            }
            .buttonStyle(.glass)
            .accessibilityIdentifier("ShowWebViewButton")
        }
        .ignoresSafeArea(edges: .top)
        .textSelection(.enabled)
        .navigationTitle(viewModel.article.source?.name ?? "EmptyArticleSource")
        .navigationSubtitle(viewModel.article.publishedAt?.toRelative ?? "EmptyArticlePublishedAt")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if let url = viewModel.article.url {
                ToolbarItem(placement: .primaryAction) {
                    ShareLink(item: url)
                        .accessibilityIdentifier("ShareLink")
                }
            }
        }
        .sheet(isPresented: $viewModel.showWebView) {
            Sheet()
        }
        .sensoryFeedback(.press(.button),
                         trigger: viewModel.sensoryFeedbackBool)
        .task {
            await viewModel.onAppear()
        }
    }

    private func Sheet() -> some View {
        NavigationStack {
            Group {
                if viewModel.showNoNetworkConnection {
                    ContentUnavailableView("ErrorDescriptionNoNetworkConnection",
                                           systemImage: "network.slash",
                                           description: Text("ErrorRecoverySuggestionNoNetworkConnection"))
                        .symbolEffect(.bounce,
                                      options: .nonRepeating)
                        .symbolVariant(.fill)
                } else {
                    WebView(url: viewModel.article.url)
                }
            }
            .navigationTitle("Headline")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close) {
                        viewModel.showWebView = false
                        viewModel.sensoryFeedbackBool.toggle()
                    }
                    .accessibilityIdentifier("CloseWebViewButton")
                }
            }
        }
    }
}

#Preview("DetailView") {
    NavigationStack {
        DetailView(viewModel: ViewModelFactory.shared.detailViewModel(article: PreviewMock.article,
                                                                      articleImage: nil))
    }
}
