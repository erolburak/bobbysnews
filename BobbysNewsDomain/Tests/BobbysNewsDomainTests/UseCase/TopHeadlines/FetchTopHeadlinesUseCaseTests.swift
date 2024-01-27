//
//  FetchTopHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class FetchTopHeadlinesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: FetchTopHeadlinesUseCase!
	private var topHeadlinesPersistenceControllerMock: TopHeadlinesPersistenceControllerMock!
	private var topHeadlinesRepositoryMock: TopHeadlinesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		topHeadlinesPersistenceControllerMock = TopHeadlinesPersistenceControllerMock()
		topHeadlinesRepositoryMock = TopHeadlinesRepositoryMock(topHeadlinesPersistenceController: topHeadlinesPersistenceControllerMock)
		sut = FetchTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		topHeadlinesPersistenceControllerMock = nil
		topHeadlinesRepositoryMock = nil
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
		XCTAssertEqual(topHeadlinesPersistenceControllerMock.queriesSubject.value?.count, 1)
	}
}
