//
//  TopHeadlinesDTOMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class TopHeadlinesDTOMappingTests: XCTestCase {

	// MARK: - Actions

	func testToDomain() {
		// Given
		let topHeadlinesDto = DTOMock.topHeadlinesDto1
		// When
		let topHeadlines = topHeadlinesDto.toDomain(country: "Test")
		// Then
		XCTAssertEqual(topHeadlines?.articles?.count, topHeadlinesDto.articles?.count)
		XCTAssertEqual(topHeadlines?.status, topHeadlinesDto.status)
		XCTAssertEqual(topHeadlines?.totalResults, topHeadlinesDto.totalResults)
	}
}
