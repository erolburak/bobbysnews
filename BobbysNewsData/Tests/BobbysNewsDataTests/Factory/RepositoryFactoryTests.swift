//
//  RepositoryFactoryTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 24.01.24.
//

import Testing

@testable import BobbysNewsData

@Suite("RepositoryFactory tests")
struct RepositoryFactoryTests {
    // MARK: - Private Properties

    private let sut = RepositoryFactory()

    // MARK: - Methods

    @Test("Check TopHeadlinesRepository initializing!")
    func topHeadlinesRepository() {
        // Given
        let topHeadlinesRepository: PTopHeadlinesRepository?
        // When
        topHeadlinesRepository = sut.topHeadlinesRepository
        // Then
        #expect(
            topHeadlinesRepository != nil,
            "TopHeadlinesRepository initializing failed!"
        )
    }
}
