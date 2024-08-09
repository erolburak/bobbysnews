//
//  ArticleDBExtensionTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsData
import XCTest

class ArticleDBExtensionTests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
	}

	override func tearDownWithError() throws {
		entity = nil
	}

	func testArticleDB() {
		// Given
		let articleAPI = entity.articleAPI
		// When
		let articleDB = ArticleDB(from: articleAPI,
								  country: "Test")
		// Then
		XCTAssertEqual(articleDB.author, articleAPI.author)
		XCTAssertEqual(articleDB.content, articleAPI.content)
		XCTAssertEqual(articleDB.publishedAt, articleAPI.publishedAt)
		XCTAssertEqual(articleDB.source?.category, articleAPI.source?.category)
		XCTAssertEqual(articleDB.source?.country, articleAPI.source?.country)
		XCTAssertEqual(articleDB.source?.id, articleAPI.source?.id)
		XCTAssertEqual(articleDB.source?.language, articleAPI.source?.language)
		XCTAssertEqual(articleDB.source?.name, articleAPI.source?.name)
		XCTAssertEqual(articleDB.source?.story, articleAPI.source?.story)
		XCTAssertEqual(articleDB.source?.url, articleAPI.source?.url)
		XCTAssertEqual(articleDB.story, articleAPI.story)
		XCTAssertEqual(articleDB.title, articleAPI.title)
		XCTAssertEqual(articleDB.url, articleAPI.url)
		XCTAssertEqual(articleDB.urlToImage, articleAPI.urlToImage)
	}
}
