//
//  Article.swift
//  BobbysNews
//
//  Created by Burak Erol on 01.09.23.
//

import Foundation

struct Article: Hashable, Identifiable {

	// MARK: - Properties

	let id = UUID()
	let author: String?
	let content: String?
	let country: Country
	let publishedAt: Date?
	let source: Source
	let story: String?
	let title: String?
	let url: URL?
	let urlToImage: URL?
}
