//
//  TopHeadlinesTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class TopHeadlinesTests: XCTestCase {

	func testTopHeadlines() {
		// Given
		let topHeadlines: TopHeadlines?
		// When
		topHeadlines = TopHeadlines(articles: [Article(author: "Test",
													   content: "Test",
													   country: "Test",
													   publishedAt: .now,
													   source: Source(category: "Test",
																	  country: "Test",
																	  id: "Test",
																	  language: "Test",
																	  name: "Test",
																	  story: "Test",
																	  url: URL(string: "Test")),
													   story: "Test",
													   title: "Test",
													   url: URL(string: "Test"),
													   urlToImage: URL(string: "Test"))],
									status: "Test",
									totalResults: 1)
		// Then
		XCTAssertNotNil(topHeadlines)
	}
}
