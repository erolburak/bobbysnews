//
//  DetailViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import Network
import SwiftUI

@Observable
final class DetailViewModel {
    // MARK: - Type Definitions

    enum StatesWebView {
        // MARK: - Properties

        /// General States
        case isLoading, loaded
        /// Error States
        case error, noNetworkConnection
    }

    // MARK: - Properties

    var article: Article
    var articleContent: String {
        (article.showTranslations ? article.contentTranslated : article.content) ?? String(localized: "EmptyArticleContent")
    }

    var articleImage: Image?

    var articleTitle: String {
        (article.showTranslations ? article.titleTranslated : article.title) ?? String(localized: "EmptyArticleTitle")
    }

    var navigationTitleOpacity: Double {
        guard let titleHeight,
              let titleScrollOffset,
              titleScrollOffset < .zero
        else {
            return .zero
        }
        return abs(titleScrollOffset) / titleHeight
    }

    var showWebView = false
    var stateWebView: StatesWebView = .isLoading
    var title: String {
        article.source?.name ?? String(localized: "EmptyArticleSource")
    }

    var titleHeight: Double?
    var titleScrollOffset: Double?

    // MARK: - Lifecycles

    init(article: Article,
         articleImage: Image?)
    {
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

    private func checkNetworkConnection() async {
        for await path in NWPathMonitor() {
            stateWebView = path.status == .unsatisfied ? .noNetworkConnection : .isLoading
        }
    }
}
