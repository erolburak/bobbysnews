//
//  ArticleEntityMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ArticleEntityMappingTests: XCTestCase {

	// MARK: - Actions

	func testArticleEntity() {
		// Given
		let articleEntity: ArticleEntity?
		// When
		articleEntity = ArticleEntity(context: DataController.shared.backgroundContext)
		articleEntity?.author = "Test"
		articleEntity?.content = "Test"
		articleEntity?.country = "Test"
		articleEntity?.publishedAt = .now
		let sourceEntity = SourceEntity(context: DataController.shared.backgroundContext)
		sourceEntity.category = "Test"
		sourceEntity.country = "Test"
		sourceEntity.id = "Test"
		sourceEntity.language = "Test"
		sourceEntity.name = "Test"
		sourceEntity.story = "Test"
		sourceEntity.url = URL(string: "Test")
		articleEntity?.source = sourceEntity
		articleEntity?.story = "Test"
		articleEntity?.title = "Test"
		articleEntity?.url = URL(string: "Test")
		articleEntity?.urlToImage = URL(string: "Test")
		// Then
		XCTAssertNotNil(articleEntity)
	}

	func testToDomain() {
		// Given
		let articleEntity = ArticleEntity(context: DataController.shared.backgroundContext)
		articleEntity.author = "Test"
		articleEntity.content = "Test"
		articleEntity.country = "Test"
		articleEntity.publishedAt = .now
		let sourceEntity = SourceEntity(context: DataController.shared.backgroundContext)
		sourceEntity.category = "Test"
		sourceEntity.country = "Test"
		sourceEntity.id = "Test"
		sourceEntity.language = "Test"
		sourceEntity.name = "Test"
		sourceEntity.story = "Test"
		sourceEntity.url = URL(string: "Test")
		articleEntity.source = sourceEntity
		articleEntity.story = "Test"
		articleEntity.title = "Test"
		articleEntity.url = URL(string: "Test")
		articleEntity.urlToImage = URL(string: "Test")
		// When
		let articleDomain = articleEntity.toDomain()
		// Then
		XCTAssertEqual(articleDomain?.author, articleEntity.author)
		XCTAssertEqual(articleDomain?.content, articleEntity.content)
		XCTAssertEqual(articleDomain?.country, articleEntity.country)
		XCTAssertNotNil(articleDomain?.publishedAt)
		XCTAssertEqual(articleDomain?.source?.category, articleEntity.source?.category)
		XCTAssertEqual(articleDomain?.source?.country, articleEntity.source?.country)
		XCTAssertEqual(articleDomain?.source?.id, articleEntity.source?.id)
		XCTAssertEqual(articleDomain?.source?.language, articleEntity.source?.language)
		XCTAssertEqual(articleDomain?.source?.name, articleEntity.source?.name)
		XCTAssertEqual(articleDomain?.source?.story, articleEntity.source?.story)
		XCTAssertNotNil(articleDomain?.source?.url)
		XCTAssertEqual(articleDomain?.story, articleEntity.story)
		XCTAssertEqual(articleDomain?.title, articleEntity.title)
		XCTAssertNotNil(articleDomain?.url)
		XCTAssertNotNil(articleDomain?.urlToImage)
	}
}
