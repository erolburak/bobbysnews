//
//  ArticleApi.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

struct ArticleApi: Decodable {

	// MARK: - Properties

	let author: String?
	let content: String?
	let publishedAt: String?
	let source: SourceApi?
	let story: String?
	let title: String?
	let url: URL?
	let urlToImage: URL?

	// MARK: - Private Properties

	private enum CodingKeys: String, CodingKey {
		case author, content, publishedAt, source, title, url, urlToImage
		case story = "description"
	}
}
