//
//  ArticleAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import XCTest

class ArticleAPITests: XCTestCase {

	// MARK: - Actions

	func testAticleAPI() {
		// Given
		let articleAPI: ArticleAPI?
		// When
		articleAPI = EntityMock.articleAPI
		// Then
		XCTAssertEqual(articleAPI?.author, "Test")
		XCTAssertEqual(articleAPI?.content, "Test")
		XCTAssertEqual(articleAPI?.publishedAt, .distantPast)
		XCTAssertEqual(articleAPI?.source?.category, "Test")
		XCTAssertEqual(articleAPI?.source?.country, "Test")
		XCTAssertEqual(articleAPI?.source?.id, "Test")
		XCTAssertEqual(articleAPI?.source?.language, "Test")
		XCTAssertEqual(articleAPI?.source?.name, "Test")
		XCTAssertEqual(articleAPI?.source?.story, "Test")
		XCTAssertEqual(articleAPI?.source?.url, URL(string: "Test"))
		XCTAssertEqual(articleAPI?.story, "Test")
		XCTAssertEqual(articleAPI?.title, "Test")
		XCTAssertEqual(articleAPI?.url, URL(string: "Test"))
		XCTAssertEqual(articleAPI?.urlToImage, URL(string: "Test"))
	}
}
