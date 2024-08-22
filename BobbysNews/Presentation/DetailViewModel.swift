//
//  DetailViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import Foundation

@Observable
final class DetailViewModel {
    // MARK: - Properties

    var article: Article
    var articleContent: String {
        article.contentTranslation ?? article.content ?? String(localized: "EmptyArticleContent")
    }

    var articleTitle: String {
        article.titleTranslation ?? article.title ?? String(localized: "EmptyArticleTitle")
    }

    var navigationTitleOffset: CGFloat?
    var navigationTitleScrollOffset: CGFloat {
        guard let navigationTitleOffset,
              let titleScrollOffset
        else {
            return .zero
        }
        if titleScrollOffset < .zero {
            return max(.zero, navigationTitleOffset - abs(titleScrollOffset))
        }
        return navigationTitleOffset
    }

    var showWebView = false {
        willSet {
            if !newValue {
                webViewIsLoading = true
                webViewShowError = false
            }
        }
    }

    var title: String {
        article.source?.name ?? String(localized: "EmptyArticleSource")
    }

    var titleScrollOffset: CGFloat?
    var webViewIsLoading = true
    var webViewShowError = false

    // MARK: - Lifecycles

    init(article: Article) {
        self.article = article
    }
}
