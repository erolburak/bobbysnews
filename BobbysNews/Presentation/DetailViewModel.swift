//
//  DetailViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

@Observable
class DetailViewModel {

	// MARK: - Properties

	var article: Article
	var navigationTitle: String {
		guard let scrollPosition else { return "" }
		return scrollPosition > 1 ? String(localized: "Headline") : ""
	}
	var scrollPosition: Int?
	var showWebView = false

	// MARK: - Life Cycle

	init(article: Article) {
		self.article = article
	}
}
