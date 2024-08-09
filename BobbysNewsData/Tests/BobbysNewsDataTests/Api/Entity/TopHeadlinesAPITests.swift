//
//  TopHeadlinesAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import XCTest

class TopHeadlinesAPITests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
	}

	override func tearDownWithError() throws {
		entity = nil
	}

	// MARK: - Actions

	func testTopHeadlinesAPI() {
		// Given
		let topHeadlinesAPI: TopHeadlinesAPI?
		// When
		topHeadlinesAPI = entity.topHeadlinesAPI
		// Then
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.author, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.content, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.publishedAt, .distantPast)
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.source?.category, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.source?.country, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.source?.id, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.source?.language, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.source?.name, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.source?.story, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.source?.url, URL(string: "Test"))
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.story, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.title, "Test")
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.url, URL(string: "Test"))
		XCTAssertEqual(topHeadlinesAPI?.articles?.first?.urlToImage, URL(string: "Test"))
	}
}
