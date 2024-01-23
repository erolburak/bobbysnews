//
//  TopHeadlinesDTO+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

struct TopHeadlinesDTO: Decodable {

	// MARK: - Properties

	let status: String?
	let totalResults: Int?
	let articles: [ArticleDTO]?
}

extension TopHeadlinesDTO {

	// MARK: - Mapping

	func toDomain() -> TopHeadlines {
		TopHeadlines(status: status,
					 totalResults: totalResults,
					 articles: articles.map { $0.toDomain() })
	}
}
