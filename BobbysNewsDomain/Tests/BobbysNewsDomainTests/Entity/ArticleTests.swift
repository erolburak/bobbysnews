//
//  ArticleTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class ArticleTests: XCTestCase {

	// MARK: - Actions

	func testArticle() {
		// Given
		let article: Article?
		// When
		article = EntityMock.article
		// Then
		XCTAssertEqual(article?.author, "Test")
		XCTAssertEqual(article?.content, "Test")
		XCTAssertNotNil(article?.publishedAt)
		XCTAssertEqual(article?.source?.category, "Test")
		XCTAssertEqual(article?.source?.country, "Test")
		XCTAssertEqual(article?.source?.id, "Test")
		XCTAssertEqual(article?.source?.language, "Test")
		XCTAssertEqual(article?.source?.name, "Test")
		XCTAssertEqual(article?.source?.story, "Test")
		XCTAssertEqual(article?.source?.url, URL(string: "Test"))
		XCTAssertEqual(article?.story, "Test")
		XCTAssertEqual(article?.title, "Test")
		XCTAssertEqual(article?.url, URL(string: "Test"))
		XCTAssertEqual(article?.urlToImage, URL(string: "Test"))
	}
}
