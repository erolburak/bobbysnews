//
//  ArticleDTOMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ArticleDTOMappingTests: XCTestCase {

	// MARK: - Actions

	func testToDomain() {
		// Given
		let articleDto = DTOMock.articleDto
		// When
		let article = articleDto.toDomain(country: "Test")
		// Then
		XCTAssertEqual(article?.author, articleDto.author)
		XCTAssertEqual(article?.content, articleDto.content)
		XCTAssertNotNil(article?.publishedAt)
		XCTAssertEqual(article?.source?.category, articleDto.source?.category)
		XCTAssertEqual(article?.source?.country, articleDto.source?.country)
		XCTAssertEqual(article?.source?.id, articleDto.source?.id)
		XCTAssertEqual(article?.source?.language, articleDto.source?.language)
		XCTAssertEqual(article?.source?.name, articleDto.source?.name)
		XCTAssertEqual(article?.source?.story, articleDto.source?.story)
		XCTAssertNotNil(article?.source?.url)
		XCTAssertEqual(article?.story, articleDto.story)
		XCTAssertEqual(article?.title, articleDto.title)
		XCTAssertNotNil(article?.url)
		XCTAssertNotNil(article?.urlToImage)
	}

	func testToEntity() {
		// Given
		let articleDto = DTOMock.articleDto
		// When
		let articleEntity = articleDto.toEntity(country: "Test",
												in: DataController.shared.backgroundContext)
		// Then
		XCTAssertEqual(articleEntity?.author, articleDto.author)
		XCTAssertEqual(articleEntity?.content, articleDto.content)
		XCTAssertNotNil(articleEntity?.publishedAt)
		XCTAssertEqual(articleEntity?.source?.category, articleDto.source?.category)
		XCTAssertEqual(articleEntity?.source?.country, articleDto.source?.country)
		XCTAssertEqual(articleEntity?.source?.id, articleDto.source?.id)
		XCTAssertEqual(articleEntity?.source?.language, articleDto.source?.language)
		XCTAssertEqual(articleEntity?.source?.name, articleDto.source?.name)
		XCTAssertEqual(articleEntity?.source?.story, articleDto.source?.story)
		XCTAssertEqual(articleEntity?.source?.url, articleDto.source?.url)
		XCTAssertEqual(articleEntity?.story, articleDto.story)
		XCTAssertEqual(articleEntity?.title, articleDto.title)
		XCTAssertNotNil(articleEntity?.url)
		XCTAssertNotNil(articleEntity?.urlToImage)
	}
}
