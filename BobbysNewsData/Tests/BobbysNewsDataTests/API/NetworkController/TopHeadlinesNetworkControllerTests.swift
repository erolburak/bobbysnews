//
//  TopHeadlinesNetworkControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import XCTest

class TopHeadlinesNetworkControllerTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: TopHeadlinesNetworkControllerMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		sut = TopHeadlinesNetworkControllerMock()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testFetch() async throws {
		// Given
		let apiKey = 1
		let country = "Test"
		// When
		let topHeadlinesAPI = try await sut
			.fetch(apiKey: apiKey,
				   country: country)
		// Then
		XCTAssertEqual(topHeadlinesAPI.articles?.count, 1)
	}
}
