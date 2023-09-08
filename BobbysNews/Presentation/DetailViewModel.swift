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
	var showWebView = false

	// MARK: - Life Cycle

	init(article: Article) {
		self.article = article
	}
}
