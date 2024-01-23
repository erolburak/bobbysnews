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

	// MARK: - Actions

	override func setUpWithError() throws {
		mock = TopHeadlinesRepositoryMock()
		sut = FetchTopHeadlinesUseCase(topHeadlinesRepository: mock)
	}

	override func tearDownWithError() throws {
		mock = nil
		sut = nil
	}

	func testFetch() async throws {
		// When
		let topHeadlines: () = try await sut.fetch(apiKey: "Test",
												   country: "Test")
		// Then
		XCTAssertNoThrow(topHeadlines)
	}
}
