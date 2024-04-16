//
//  EntityMock.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

import BobbysNewsData
import BobbysNewsDomain
import Foundation

class EntityMock {

	// MARK: - Properties

	/// Mocks which represent Domain entities
	static let article = Article(author: "Test",
								 content: "Test",
								 country: "Test",
								 publishedAt: .distantPast,
								 source: source,
								 story: "Test",
								 title: "Test",
								 url: URL(string: "Test"),
								 urlToImage: URL(string: "Test"))
	static let errors: [Errors] = [.error("ErrorDescription"),
								   .fetchSources,
								   .fetchTopHeadlines,
								   .invalidApiKey,
								   .limitedRequests,
								   .read,
								   .reset]
	static let source = Source(category: "Test",
							   country: "Test",
							   id: "Test",
							   language: "Test",
							   name: "Test",
							   story: "Test",
							   url: URL(string: "Test"))
	static let sources = Sources(sources: [source])
	static let topHeadlines = TopHeadlines(articles: [article])

	/// Mocks which represent DB entities
	static let articleDB = {
		let articleDB = ArticleDB(context: PersistenceController.shared.backgroundContext)
		articleDB.author = "Test"
		articleDB.content = "Test"
		articleDB.country = "Test"
		articleDB.publishedAt = .distantPast
		articleDB.source = sourceDB
		articleDB.story = "Test"
		articleDB.title = "Test"
		articleDB.url = URL(string: "Test")
		articleDB.urlToImage = URL(string: "Test")
		return articleDB
	}()
	static let sourceDB = {
		let sourceDB = SourceDB(context: PersistenceController.shared.backgroundContext)
		sourceDB.category = "Test"
		sourceDB.country = "Test"
		sourceDB.id = "Test"
		sourceDB.language = "Test"
		sourceDB.name = "Test"
		sourceDB.story = "Test"
		sourceDB.url = URL(string: "Test")
		return sourceDB
	}()
	static let sourcesDB = [sourceDB]
	static let topHeadlinesDB = [articleDB]
}
