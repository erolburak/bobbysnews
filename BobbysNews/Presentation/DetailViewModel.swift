//
//  DetailViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsDomain
import Foundation

final class DetailViewModel: ObservableObject {

	// MARK: - Properties

	@Published var article: Article
	@Published var scrollPosition: Int?
	@Published var showNavigationTitle = false
	@Published var webViewIsLoading = true
	@Published var webViewShowError = false
	@Published var showWebView = false {
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

	// MARK: - Inits

	init(article: Article) {
		self.article = article
	}
}
