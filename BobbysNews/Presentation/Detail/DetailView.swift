//
//  DetailView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import SwiftUI

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
                        .frame(maxHeight: 500)
                        .clipped()
                } else {
                    AsyncImage(url: viewModel.article.image) {
                        switch $0 {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxHeight: 500)
                                .clipped()
                        case .failure:
                            Spacer()

                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 32)
                                .foregroundStyle(.gray)
                                .symbolEffect(
                                    .bounce,
                                    options: .nonRepeating
                                )
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
            .ignoresSafeArea(edges: .horizontal)
            .frame(minHeight: 500)
            .offset(
                y: viewModel.scrollGeometryContentOffsetY >= 0
                    ? viewModel.scrollGeometryContentOffsetY : 0
            )
            .overlay(alignment: .bottom) {
                OffsetOverlay()
            }
            .overlay(alignment: .bottom) {
                LinearGradientOverlay()
            }
            .visualEffect { emptyVisualEffect, geometryProxy in
                let geometryProxyHeight = geometryProxy.size.height
                return emptyVisualEffect.scaleEffect(
                    (geometryProxyHeight
                        + max(
                            0,
                            geometryProxy.frame(in: .scrollView).minY)) / geometryProxyHeight,
                    anchor: .bottom
                )
            }

            VStack(alignment: .leading) {
                Text(viewModel.articleTitle)
                    .font(.title)
                    .fontWeight(.black)
                    .padding(.bottom)

                Text(viewModel.articleContent)
                    .padding(.bottom)
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(
                .top,
                -120
            )
            .padding([
                .horizontal,
                .bottom,
            ])

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
            Toolbar()
        }
        .sheet(isPresented: $viewModel.showWebView) {
            Sheet()
        }
        .onScrollGeometryChange(for: CGFloat.self) { scrollGeometry in
            scrollGeometry.contentOffset.y
        } action: { _, newValue in
            viewModel.scrollGeometryContentOffsetY = newValue / 1.75
        }
        .sensoryFeedback(
            .press(.button),
            trigger: viewModel.sensoryFeedbackBool
        )
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview("DetailView") {
    NavigationStack {
        DetailView(
            viewModel: ViewModelFactory.shared.detailViewModel(
                article: PreviewMock.article,
                articleImage: nil
            )
        )
    }
}
