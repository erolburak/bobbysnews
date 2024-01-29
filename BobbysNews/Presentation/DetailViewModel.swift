//
//  DetailViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import Foundation

@Observable
class DetailViewModel {

	// MARK: - Properties

	var article: Article
	var navigationTitle: String {
		guard let scrollPosition else {
			return ""
		}
		return scrollPosition >= 1 ? title : ""
	}
	var scrollPosition: Int?
	var showWebView = false {
		willSet {
			if newValue == false {
				webViewIsLoading = true
			}
		}
	}
	var title: String {
		article.source?.name ?? String(localized: "EmptyArticleSource")
	}
	var webViewIsLoading = true

	// MARK: - Inits

	init(article: Article) {
		self.article = article
	}
}
