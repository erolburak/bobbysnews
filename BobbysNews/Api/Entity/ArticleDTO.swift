//
//  ArticleDTO.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

struct ArticleDTO: Decodable {

	// MARK: - Properties

	let source: SourceDTO
	let author: String?
	let title: String?
	let description: String?
	let url: String?
	let urlToImage: String?
	let publishedAt: String?
	let content: String?
}

extension ArticleDTO {

	// MARK: - Mapper

	func toDomain() -> Article {
		Article(source: source.toDomain(),
				author: author,
				title: title,
				description: description,
				url: url,
				urlToImage: urlToImage,
				publishedAt: publishedAt,
				content: content)
	}
}
