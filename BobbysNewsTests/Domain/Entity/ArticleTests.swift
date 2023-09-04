//
//  ArticleTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ArticleTests: XCTestCase {

	func testArticle() {
		// Given
		let article: Article?
		// When
		article = Article(author: "Test",
						  content: "Test",
						  country: .germany,
						  publishedAt: .now,
						  source: Source(id: "Test",
										 name: "Test"),
						  story: "Test",
						  title: "Test",
						  url: URL(string: "Test"),
						  urlToImage: URL(string: "Test"))
		// Then
		XCTAssertNotNil(article)
	}
}
