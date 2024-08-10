//
//  FetchSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
import Testing

struct FetchSourcesUseCaseTests {

	// MARK: - Private Properties

	private let mock: SourcesRepositoryMock
	private let sut: FetchSourcesUseCase

	// MARK: - Inits

	init() {
		mock = SourcesRepositoryMock()
		sut = FetchSourcesUseCase(sourcesRepository: mock)
	}

	// MARK: - Actions

	@Test("Check FetchSourcesUseCase fetch!")
	func testFetch() async throws {
		// Given
		let apiKey = 1
		// When
		try await sut.fetch(apiKey: apiKey)
		// Then
		#expect(mock.sourcesPersistenceController.read().count == 1,
				"FetchSourcesUseCase fetch failed!")
	}
}
