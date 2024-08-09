//
//  TopHeadlinesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class TopHeadlinesTests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
	}

	override func tearDownWithError() throws {
		entity = nil
	}

	func testTopHeadlines() {
		// Given
		let topHeadlines: TopHeadlines?
		// When
		topHeadlines = entity.topHeadlines
		// Then
		XCTAssertEqual(topHeadlines?.articles?.first?.author, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.content, "Test")
		XCTAssertNotNil(topHeadlines?.articles?.first?.publishedAt)
		XCTAssertEqual(topHeadlines?.articles?.first?.source?.category, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.source?.country, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.source?.id, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.source?.language, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.source?.name, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.source?.story, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.source?.url, URL(string: "Test"))
		XCTAssertEqual(topHeadlines?.articles?.first?.story, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.title, "Test")
		XCTAssertEqual(topHeadlines?.articles?.first?.url, URL(string: "Test"))
		XCTAssertEqual(topHeadlines?.articles?.first?.urlToImage, URL(string: "Test"))
	}
}
