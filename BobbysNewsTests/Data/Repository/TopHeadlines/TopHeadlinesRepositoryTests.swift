//
//  TopHeadlinesRepositoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class TopHeadlinesRepositoryTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: TopHeadlinesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		sut = TopHeadlinesRepositoryMock()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testFetchIsNotNil() async throws {
		// Given
		var topHeadlinesApi: TopHeadlinesApi?
		// When
		topHeadlinesApi = try await sut.fetch(apiKey: "Test",
											  country: "Test")
		// Then
		XCTAssertNotNil(topHeadlinesApi)
	}

	func testFetchIsNil() async throws {
		// Given
		var topHeadlinesApi: TopHeadlinesApi?
		// When
		do {
			topHeadlinesApi = try await sut.fetch(apiKey: "",
												  country: "")
		} catch {
			// Then
			XCTAssertNil(topHeadlinesApi)
			XCTAssertNotNil(error)
		}
	}
}
