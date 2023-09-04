//
//  TopHeadlinesDTO+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

struct TopHeadlinesDTO: Decodable {

	// MARK: - Properties

	let articles: [ArticleDTO]?
	let status: String?
	let totalResults: Int?
}

extension TopHeadlinesDTO {

	// MARK: - Mapping

	func toDomain(country: Country) -> TopHeadlines {
		TopHeadlines(articles: articles?.compactMap { $0.toDomain(country: country) },
					 status: status,
					 totalResults: totalResults)
	}
}
