//
//  EntityMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 06.09.23.
//

@testable import BobbysNews
import Foundation

struct EntityMock {

	// MARK: - Properties

	static let articleEntity1 = {
		let articleEntity = ArticleEntity(context: DataController.shared.backgroundContext)
		articleEntity.author = "Test 1"
		articleEntity.content = "Test 1"
		articleEntity.country = "Test 1"
		articleEntity.publishedAt = "2001-02-03T12:34:56Z".toDate
		articleEntity.source = sourceEntity1
		articleEntity.story = "Test 1"
		articleEntity.title = "Test 1"
		articleEntity.url = URL(string: "Test 1")
		articleEntity.urlToImage = URL(string: "Test 1")
		return articleEntity
	}()
	static let articleEntity2 = {
		let articleEntity = ArticleEntity(context: DataController.shared.backgroundContext)
		articleEntity.author = "Test 2"
		articleEntity.content = "Test 2"
		articleEntity.country = "Test 2"
		articleEntity.publishedAt = "2001-02-03T12:34:56Z".toDate
		articleEntity.source = sourceEntity2
		articleEntity.story = "Test 2"
		articleEntity.title = "Test 2"
		articleEntity.url = URL(string: "Test 2")
		articleEntity.urlToImage = URL(string: "Test 2")
		return articleEntity
	}()
	static let sourceEntity1 = {
		let sourceEntity = SourceEntity(context: DataController.shared.backgroundContext)
		sourceEntity.category = "Test 1"
		sourceEntity.country = "Test 1"
		sourceEntity.id = "Test 1"
		sourceEntity.language = "Test 1"
		sourceEntity.name = "Test 1"
		sourceEntity.story = "Test 1"
		sourceEntity.url = URL(string: "Test 1")
		return sourceEntity
	}()
	static let sourceEntity2 = {
		let sourceEntity = SourceEntity(context: DataController.shared.backgroundContext)
		sourceEntity.category = "Test 2"
		sourceEntity.country = "Test 2"
		sourceEntity.id = "Test 2"
		sourceEntity.language = "Test 2"
		sourceEntity.name = "Test 2"
		sourceEntity.story = "Test 2"
		sourceEntity.url = URL(string: "Test 2")
		return sourceEntity
	}()
	static let sourcesEntity: Sources? = {
		guard let source1 = Source(from: sourceEntity1),
			  let source2 = Source(from: sourceEntity2) else { return nil }
		return Sources(sources: [source1,
								 source2],
					   status: "Test 1")
	}()
	static let topHeadlinesEntity: TopHeadlines? = {
		TopHeadlines(articles: [Article(from: articleEntity1),
								Article(from: articleEntity2)],
					 status: "Test 1",
					 totalResults: 2)
	}()
}
