//
//  FetchTopHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import BobbysNewsData
@testable import BobbysNewsDomain
import Testing

@Suite("FetchTopHeadlinesUseCase tests")
struct FetchTopHeadlinesUseCaseTests {
    // MARK: - Private Properties

    private let mock: TopHeadlinesRepositoryMock
    private let sut: FetchTopHeadlinesUseCase

    // MARK: - Lifecycles

    init() {
        mock = TopHeadlinesRepositoryMock()
        sut = FetchTopHeadlinesUseCase(topHeadlinesRepository: mock)
    }

    @Test("Check FetchTopHeadlinesUseCase fetch!")
    func fetch() async throws {
        // Given
        let apiKey = 1
        let country = "uk"
        // When
        try await sut.fetch(apiKey: apiKey,
                            country: country)
        // Then
        #expect(mock.topHeadlinesPersistenceController.read(country: country).count == 1,
                "FetchTopHeadlinesUseCase fetch failed!")
    }
}
