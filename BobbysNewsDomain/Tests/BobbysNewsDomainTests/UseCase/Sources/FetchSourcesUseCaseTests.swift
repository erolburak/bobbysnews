//
//  FetchSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
import XCTest

class FetchSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var mock: SourcesRepositoryMock!
	private var sut: FetchSourcesUseCase!

	// MARK: - Actions

	override func setUpWithError() throws {
		mock = SourcesRepositoryMock()
		sut = FetchSourcesUseCase(sourcesRepository: mock)
	}

	override func tearDownWithError() throws {
		mock = nil
		sut = nil
	}

	func testFetch() async throws {
		// Given
		let apiKey = 1
		// When
		try await sut
			.fetch(apiKey: apiKey)
		// Then
		XCTAssertEqual(mock.sourcesPersistenceController.queriesSubject.value?.count, 2)
	}
}
