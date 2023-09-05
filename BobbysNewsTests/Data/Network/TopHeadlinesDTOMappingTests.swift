//
//  TopHeadlinesDTOMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class TopHeadlinesDTOMappingTests: XCTestCase {

	func testToDomain() {
		// Given
		let topHeadlinesDto = TopHeadlinesDTO(articles: [ArticleDTO(author: "Test",
																	content: "Test",
																	publishedAt: "2001-02-03T12:34:56Z",
																	source: SourceDTO(category: "Test",
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
		// When
		let topHeadlines = topHeadlinesDto.toDomain(country: "Test")
		// Then
		XCTAssertEqual(topHeadlines?.articles?.count, topHeadlinesDto.articles?.count)
		XCTAssertEqual(topHeadlines?.status, topHeadlinesDto.status)
		XCTAssertEqual(topHeadlines?.totalResults, topHeadlinesDto.totalResults)
	}
}
