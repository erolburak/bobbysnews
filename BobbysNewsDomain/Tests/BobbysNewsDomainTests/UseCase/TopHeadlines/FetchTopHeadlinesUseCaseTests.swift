//
//  FetchTopHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
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
		// Given
		let apiKey = 1
		let country = "Test"
		// When
		try await sut
			.fetch(apiKey: apiKey,
				   country: country)
		// Then
		XCTAssertEqual(mock.topHeadlinesPersistenceController.queriesSubject.value?.count, 2)
	}
}
