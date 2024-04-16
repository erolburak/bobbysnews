//
//  ArticleDB+Extension.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

extension ArticleDB {

	// MARK: - Inits

	@discardableResult
	public convenience init(from api: ArticleAPI,
							country: String) {
		self.init(context: PersistenceController.shared.backgroundContext)
		self.author = api.author
		self.content = api.content
		self.country = country
		self.publishedAt = api.publishedAt
		if let sourceAPI = api.source {
			self.source = SourceDB(from: sourceAPI)
		}
		self.story = api.story
		self.title = api.title
		self.url = api.url
		self.urlToImage = api.urlToImage
	}
}
