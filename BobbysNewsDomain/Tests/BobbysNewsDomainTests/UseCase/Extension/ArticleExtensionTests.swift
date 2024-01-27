//
//  ArticleExtensionTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsDomain
import XCTest

class ArticleExtensionTests: XCTestCase {

	// MARK: - Actions

	func testArticle() {
		// Given
		let articleDB = EntityMock.articleDB
		// When
		let article = Article(from: articleDB)
		// Then
		XCTAssertEqual(article.author, articleDB.author)
		XCTAssertEqual(article.content, articleDB.content)
		XCTAssertEqual(article.publishedAt, articleDB.publishedAt)
		XCTAssertEqual(article.source?.category, articleDB.source?.category)
		XCTAssertEqual(article.source?.country, articleDB.source?.country)
		XCTAssertEqual(article.source?.id, articleDB.source?.id)
		XCTAssertEqual(article.source?.language, articleDB.source?.language)
		XCTAssertEqual(article.source?.name, articleDB.source?.name)
		XCTAssertEqual(article.source?.story, articleDB.source?.story)
		XCTAssertEqual(article.source?.url, articleDB.source?.url)
		XCTAssertEqual(article.story, articleDB.story)
		XCTAssertEqual(article.title, articleDB.title)
		XCTAssertEqual(article.url, articleDB.url)
		XCTAssertEqual(article.urlToImage, articleDB.urlToImage)
	}
}
