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
	var scrollPosition: Int?
	var showNavigationTitle = false
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
	var webViewIsLoading = true
	var webViewShowError = false

	// MARK: - Inits

	init(article: Article) {
		self.article = article
	}
}
