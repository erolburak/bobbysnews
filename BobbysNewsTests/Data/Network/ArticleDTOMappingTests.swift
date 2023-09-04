//
//  ArticleDTOMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ArticleDTOMappingTests: XCTestCase {

	func testToDomain() {
		// Given
		let articleDto = ArticleDTO(author: "Test",
									content: "Test",
									publishedAt: "2001-02-03T12:34:56Z",
									source: SourceDTO(id: "Test",
													  name: "Test"),
									story: "Test",
									title: "Test",
									url: URL(string: "Test"),
									urlToImage: URL(string: "Test"))
		// When
		let article = articleDto.toDomain(country: .germany)
		// Then
		XCTAssertEqual(article?.author, articleDto.author)
		XCTAssertEqual(article?.content, articleDto.content)
		XCTAssertNotNil(article?.publishedAt)
		XCTAssertEqual(article?.source.id, articleDto.source.id)
		XCTAssertEqual(article?.source.name, articleDto.source.name)
		XCTAssertEqual(article?.story, articleDto.story)
		XCTAssertEqual(article?.title, articleDto.title)
		XCTAssertNotNil(article?.url)
		XCTAssertNotNil(article?.urlToImage)
	}

	func testToEntity() {
		// Given
		let articleDto = ArticleDTO(author: "Test",
									content: "Test",
									publishedAt: "2001-02-03T12:34:56Z",
									source: SourceDTO(id: "Test",
													  name: "Test"),
									story: "Test",
									title: "Test",
									url: URL(string: "Test"),
									urlToImage: URL(string: "Test"))
		// When
		let articleEntity = articleDto.toEntity(country: .germany,
												in: DataController.shared.backgroundContext)
		// Then
		XCTAssertEqual(articleEntity?.author, articleDto.author)
		XCTAssertEqual(articleEntity?.content, articleDto.content)
		XCTAssertNotNil(articleEntity?.publishedAt)
		XCTAssertEqual(articleEntity?.sourceId, articleDto.source.id)
		XCTAssertEqual(articleEntity?.sourceName, articleDto.source.name)
		XCTAssertEqual(articleEntity?.story, articleDto.story)
		XCTAssertEqual(articleEntity?.title, articleDto.title)
		XCTAssertNotNil(articleEntity?.url)
		XCTAssertNotNil(articleEntity?.urlToImage)
	}
}
