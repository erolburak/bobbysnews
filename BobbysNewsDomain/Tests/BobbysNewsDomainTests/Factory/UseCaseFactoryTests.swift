//
//  UseCaseFactoryTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 25.01.24.
//

import Testing

@testable import BobbysNewsDomain

@Suite("RepositoryFactory tests")
struct RepositoryFactoryTests {
    // MARK: - Private Properties

    private let sut = UseCaseFactory()

    // MARK: - Methods

    @Test("Check DeleteTopHeadlinesUseCase initializing!")
    func deleteTopHeadlinesUseCase() {
        // Given
        let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase?
        // When
        deleteTopHeadlinesUseCase = sut.deleteTopHeadlinesUseCase
        // Then
        #expect(
            deleteTopHeadlinesUseCase != nil,
            "DeleteTopHeadlinesUseCase initializing failed!"
        )
    }

    @Test("Check FetchTopHeadlinesUseCase initializing!")
    func fetchTopHeadlinesUseCase() {
        // Given
        let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase?
        // When
        fetchTopHeadlinesUseCase = sut.fetchTopHeadlinesUseCase
        // Then
        #expect(
            fetchTopHeadlinesUseCase != nil,
            "FetchTopHeadlinesUseCase initializing failed!"
        )
    }

    @Test("Check ReadTopHeadlinesUseCase initializing!")
    func readTopHeadlinesUseCase() {
        // Given
        let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase?
        // When
        readTopHeadlinesUseCase = sut.readTopHeadlinesUseCase
        // Then
        #expect(
            readTopHeadlinesUseCase != nil,
            "ReadTopHeadlinesUseCase initializing failed!"
        )
    }
}
