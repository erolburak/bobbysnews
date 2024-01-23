//
//  TopHeadlinesDataController+Mapping.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.01.24.
//

import CoreData

extension Article {

	// MARK: - Inits

	init(from entity: ArticleEntity) {
		self.init(author: entity.author,
				  content: entity.content,
				  country: entity.country,
				  publishedAt: entity.publishedAt,
				  source: Source(from: entity.source),
				  story: entity.story,
				  title: entity.title,
				  url: entity.url,
				  urlToImage: entity.urlToImage)
	}
}

extension ArticleEntity {

	// MARK: - Inits

	@discardableResult
	convenience init?(from api: ArticleApi?,
					  country: String,
					  in context: NSManagedObjectContext) {
		guard let api,
			  api.source?.id?.localizedStandardContains("removed") == false,
			  api.source?.name?.localizedStandardContains("removed") == false else { return nil }
		self.init(context: context)
		self.author = api.author
		self.content = api.content
		self.country = country
		self.publishedAt = api.publishedAt?.toDate
		self.source = SourceEntity(from: api.source,
								   in: context)
		self.story = api.story
		self.title = api.title
		self.url = api.url
		self.urlToImage = api.urlToImage
	}
}
