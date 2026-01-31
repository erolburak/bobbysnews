//
//  ContentListItem.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.06.25.
//

import BobbysNewsDomain
import SwiftUI

struct ContentListItem: View {
    // MARK: - Private Properties

    @Namespace private var animation
    @State private var articleImage: Image?
    @State private var showTranslationPresentation = false
    @State private var translationPresentationText = ""

    // MARK: - Properties

    @Binding var article: Article

    // MARK: - Layouts

    var body: some View {
        NavigationLink {
            DetailView(
                viewModel: ViewModelFactory.shared.detailViewModel(
                    article: article,
                    articleImage: articleImage
                )
            )
            .navigationTransition(
                .zoom(
                    sourceID: article.id,
                    in: animation
                )
            )
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(article.source?.name ?? String(localized: "EmptyArticleSource"))
                        .font(
                            .system(
                                .subheadline,
                                weight: .black
                            )
                        )
                        .lineLimit(1)

                    Text(
                        article.publishedAt?.toRelative
                            ?? String(localized: "EmptyArticlePublishedAt")
                    )
                    .font(
                        .system(
                            .subheadline,
                            weight: .semibold
                        )
                    )

                    Spacer()

                    Text(
                        (article.showTranslations ? article.titleTranslated : article.title)
                            ?? String(localized: "EmptyArticleTitle")
                    )
                    .font(
                        .system(
                            .subheadline,
                            weight: .semibold
                        )
                    )
                    .lineLimit(2)
                }
                .multilineTextAlignment(.leading)

                Spacer()

                AsyncImage(
                    url: article.image,
                    transaction: Transaction(animation: .easeIn(duration: 0.75))
                ) {
                    switch $0 {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: 80,
                                height: 80,
                                alignment: .center
                            )
                            .clipped()
                            .onAppear {
                                articleImage = image
                            }
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                            .foregroundStyle(.gray)
                            .symbolEffect(
                                .bounce,
                                options: .nonRepeating
                            )
                    default:
                        ProgressView()
                    }
                }
                .frame(
                    width: 80,
                    height: 80
                )
                .background(.bar)
                .clipShape(.rect(cornerRadius: 12))
            }
            .padding(.horizontal)
            .padding(
                .vertical,
                20
            )
            .contentShape(.rect)
            .contextMenu {
                if let url = article.url {
                    ShareLink(
                        "Share",
                        item: url
                    )
                }

                if let title = article.title {
                    Button(
                        "Translate",
                        systemImage: "translate"
                    ) {
                        translationPresentationText = title
                        showTranslationPresentation = true
                    }
                }
            }
            .translationPresentation(
                isPresented: $showTranslationPresentation,
                text: translationPresentationText
            )
        }
        .sensoryFeedback(
            .selection,
            trigger: showTranslationPresentation
        )
        .matchedTransitionSource(
            id: article.id,
            in: animation
        )
        .accessibilityIdentifier(Accessibility.contentListItem.id)
    }
}

#Preview("ContentListItem") {
    NavigationStack {
        ScrollView {
            ContentListItem(article: .constant(PreviewMock.article))
        }
    }
}
