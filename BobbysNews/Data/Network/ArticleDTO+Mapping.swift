//
//  ArticleDTO+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import CoreData

struct ArticleDTO: Decodable {

	// MARK: - Properties

	let author: String?
	let content: String?
	let publishedAt: String?
	let source: SourceDTO
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

extension ArticleDTO {

	// MARK: - Mapping

	func toDomain(country: Country) -> Article? {
		Article(author: author,
				content: content,
				country: country,
				publishedAt: publishedAt?.toDate,
				source: source.toDomain(),
				story: story,
				title: title,
				url: url,
				urlToImage: urlToImage)
	}
}

extension ArticleDTO {

	// MARK: - Mapping

	@discardableResult
	func toEntity(country: Country, in context: NSManagedObjectContext) -> ArticleEntity? {
		if source.name?.localizedStandardContains("removed") == false {
			let entity = ArticleEntity(context: context)
			entity.author = author
			entity.content = content
			entity.country = country.rawValue
			entity.publishedAt = publishedAt?.toDate
			entity.sourceId = source.id
			entity.sourceName = source.name
			entity.story = story
			entity.title = title
			entity.url = url
			entity.urlToImage = urlToImage
			return entity
		}
		return nil
	}
}
