//
//  DetailViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import Network
import SwiftUI
import WebKit

@Observable
final class DetailViewModel {
    // MARK: - Properties

    var article: Article
    var articleContent: String {
        (article.showTranslations ? article.contentTranslated : article.content)
            ?? String(localized: "EmptyArticleContent")
    }

    var articleImage: Image?
    var articleTitle: String {
        (article.showTranslations ? article.titleTranslated : article.title)
            ?? String(localized: "EmptyArticleTitle")
    }

    var scrollGeometryYOffset: CGFloat = 0
    var sensoryFeedbackBool = false
    var showNoNetworkConnection = false
    var showWebView = false
    var webPage: WebPage?

    // MARK: - Lifecycles

    init(
        article: Article,
        articleImage: Image?
    ) {
        self.article = article
        self.articleImage = articleImage
    }

    // MARK: - Methods

    @MainActor
    func onAppear() async {
        Task {
            await checkNetworkConnection()
        }
    }

    @MainActor
    func loadWebPage() {
        if let url = article.url,
            !showNoNetworkConnection,
            showWebView,
            webPage == nil
        {
            webPage = WebPage()
            webPage?.load(URLRequest(url: url))
        }
    }

    private func checkNetworkConnection() async {
        for await path in NWPathMonitor() {
            showNoNetworkConnection = path.status == .unsatisfied
        }
    }
}
