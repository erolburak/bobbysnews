//
//  ArticleEntityMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ArticleEntityMappingTests: XCTestCase {

	func testToDomain() {
		// Given
		let articleEntity = ArticleEntity(context: DataController.shared.backgroundContext)
		articleEntity.author = "Test"
		articleEntity.content = "Test"
		articleEntity.country = "germany"
		articleEntity.publishedAt = .now
		articleEntity.sourceId = "Test"
		articleEntity.sourceName = "Test"
		articleEntity.story = "Test"
		articleEntity.title = "Test"
		articleEntity.url = URL(string: "Test")
		articleEntity.urlToImage = URL(string: "Test")
		// When
		let articleDomain = articleEntity.toDomain()
		// Then
		XCTAssertEqual(articleDomain.author, articleEntity.author)
		XCTAssertEqual(articleDomain.content, articleEntity.content)
		XCTAssertNotNil(articleDomain.publishedAt)
		XCTAssertEqual(articleDomain.source.id, articleEntity.sourceId)
		XCTAssertEqual(articleDomain.source.name, articleEntity.sourceName)
		XCTAssertEqual(articleDomain.story, articleEntity.story)
		XCTAssertEqual(articleDomain.title, articleEntity.title)
		XCTAssertNotNil(articleDomain.url)
		XCTAssertNotNil(articleDomain.urlToImage)
	}
}
