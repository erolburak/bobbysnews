//
//  FetchSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class FetchSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: FetchSourcesUseCase!
	private var sourcesPersistenceControllerMock: SourcesPersistenceControllerMock!
	private var sourcesRepositoryMock: SourcesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		sourcesPersistenceControllerMock = SourcesPersistenceControllerMock()
		sourcesRepositoryMock = SourcesRepositoryMock(sourcesPersistenceController: sourcesPersistenceControllerMock)
		sut = FetchSourcesUseCase(sourcesRepository: sourcesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		sourcesPersistenceControllerMock = nil
		sourcesRepositoryMock = nil
	}

	func testFetch() async throws {
		// Given
		let apiKey = 1
		// When
		try await sut
			.fetch(apiKey: apiKey)
		// Then
		XCTAssertEqual(sourcesPersistenceControllerMock.queriesSubject.value?.count, 1)
	}
}
