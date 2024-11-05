//
//  FetchSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

import BobbysNewsData
@testable import BobbysNewsDomain
import Testing

@Suite("FetchSourcesUseCase tests")
struct FetchSourcesUseCaseTests {
    // MARK: - Private Properties

    private let mock: SourcesRepositoryMock
    private let sut: FetchSourcesUseCase

    // MARK: - Lifecycles

    init() {
        mock = SourcesRepositoryMock()
        sut = FetchSourcesUseCase(sourcesRepository: mock)
    }

    // MARK: - Methods

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
