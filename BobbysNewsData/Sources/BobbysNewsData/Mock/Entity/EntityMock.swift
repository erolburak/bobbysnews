//
//  EntityMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 06.09.23.
//

import Foundation

public struct EntityMock {

	// MARK: - Properties

	/// Mocks which represent API entities
	static let articleAPI = ArticleAPI(author: "Test",
									   content: "Test",
									   publishedAt: .distantPast,
									   source: sourceAPI,
									   story: "Test",
									   title: "Test",
									   url: URL(string: "Test"),
									   urlToImage: URL(string: "Test"))
	static let sourceAPI = SourceAPI(category: "Test",
									 country: "Test",
									 id: "Test",
									 language: "Test",
									 name: "Test",
									 story: "Test",
									 url: URL(string: "Test"))
	public static let sourcesAPI = SourcesAPI(sources: [sourceAPI])
	public static let topHeadlinesAPI = TopHeadlinesAPI(articles: [articleAPI])

	/// Mocks which represent DB entities
	public lazy var articleDB = {
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
	public lazy var sourceDB = {
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
	public lazy var sourcesDB = [sourceDB]
	public lazy var topHeadlinesDB = [articleDB]
}
