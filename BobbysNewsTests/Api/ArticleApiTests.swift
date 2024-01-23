//
//  ArticleApiTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ArticleApiTests: XCTestCase {

	// MARK: - Actions

	func testAticleApi() {
		// Given
		let articleApi: ArticleApi?
		// When
		articleApi = ArticleApi(author: "Test",
								content: "Test",
								publishedAt: "2001-02-03T12:34:56Z",
								source: SourceApi(category: "Test",
												  country: "Test",
												  id: "Test",
												  language: "Test",
												  name: "Test",
												  story: "Test",
												  url: URL(string: "Test")),
								story: "Test",
								title: "Test",
								url: URL(string: "Test"),
								urlToImage: URL(string: "Test"))
		// Then
		XCTAssertNotNil(articleApi)
	}
}
