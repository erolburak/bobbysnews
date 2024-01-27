//
//  ArticleDB+Extension.swift
//	BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

extension ArticleDB {

	// MARK: - Inits

	@discardableResult
	public convenience init?(from api: ArticleAPI?,
							 country: String) {
		guard let api,
			  api.source?.id?.localizedStandardContains("removed") == false,
			  api.source?.name?.localizedStandardContains("removed") == false else { return nil }
		self.init(context: PersistenceController.shared.backgroundContext)
		self.author = api.author
		self.content = api.content
		self.country = country
		self.publishedAt = api.publishedAt?.toDate
		self.source = SourceDB(from: api.source)
		self.story = api.story
		self.title = api.title
		self.url = api.url
		self.urlToImage = api.urlToImage
	}
}
