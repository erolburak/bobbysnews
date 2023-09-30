//
//  FetchTopHeadlinesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class FetchTopHeadlinesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var mock: TopHeadlinesRepositoryMock!
	private var sut: FetchTopHeadlinesUseCase!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		mock = TopHeadlinesRepositoryMock()
		sut = FetchTopHeadlinesUseCase(topHeadlinesRepository: mock)
	}

	override func tearDownWithError() throws {
		mock = nil
		sut = nil
	}

	// MARK: - Actions

	func testFetchIsNotNil() async throws {
		// Given
		var topHeadlinesDto: TopHeadlinesDTO?
		// When
		topHeadlinesDto = try await sut.fetch(apiKey: "Test",
											  country: "Test")
		// Then
		XCTAssertNotNil(topHeadlinesDto)
	}

	func testFetchIsNil() async throws {
		// Given
		var topHeadlinesDto: TopHeadlinesDTO?
		// When
		do {
			topHeadlinesDto = try await sut.fetch(apiKey: "",
												  country: "")
		} catch {
			// Then
			XCTAssertNil(topHeadlinesDto)
			XCTAssertNotNil(error)
		}
	}
}
