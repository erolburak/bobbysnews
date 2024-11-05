//
//  UseCaseFactoryTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 25.01.24.
//

@testable import BobbysNewsDomain
import Testing

@Suite("RepositoryFactory tests")
struct RepositoryFactoryTests {
    // MARK: - Private Properties

    private let sut = UseCaseFactory()

    // MARK: - Methods

    @Test("Check DeleteSourcesUseCase initializing!")
    func testDeleteSourcesUseCase() {
        // Given
        let deleteSourcesUseCase: PDeleteSourcesUseCase?
        // When
        deleteSourcesUseCase = sut.deleteSourcesUseCase
        // Then
        #expect(deleteSourcesUseCase != nil,
                "DeleteSourcesUseCase initializing failed!")
    }

    @Test("Check FetchSourcesUseCase initializing!")
    func testFetchSourcesUseCase() {
        // Given
        let fetchSourcesUseCase: PFetchSourcesUseCase?
        // When
        fetchSourcesUseCase = sut.fetchSourcesUseCase
        // Then
        #expect(fetchSourcesUseCase != nil,
                "FetchSourcesUseCase initializing failed!")
    }

    @Test("Check ReadSourcesUseCase initializing!")
    func testReadSourcesUseCase() {
        // Given
        let readSourcesUseCase: PReadSourcesUseCase?
        // When
        readSourcesUseCase = sut.readSourcesUseCase
        // Then
        #expect(readSourcesUseCase != nil,
                "ReadSourcesUseCase initializing failed!")
    }

    @Test("Check DeleteTopHeadlinesUseCase initializing!")
    func testDeleteTopHeadlinesUseCase() {
        // Given
        let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase?
        // When
        deleteTopHeadlinesUseCase = sut.deleteTopHeadlinesUseCase
        // Then
        #expect(deleteTopHeadlinesUseCase != nil,
                "DeleteTopHeadlinesUseCase initializing failed!")
    }

    @Test("Check FetchTopHeadlinesUseCase initializing!")
    func testFetchTopHeadlinesUseCase() {
        // Given
        let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase?
        // When
        fetchTopHeadlinesUseCase = sut.fetchTopHeadlinesUseCase
        // Then
        #expect(fetchTopHeadlinesUseCase != nil,
                "FetchTopHeadlinesUseCase initializing failed!")
    }

    @Test("Check ReadTopHeadlinesUseCase initializing!")
    func testReadTopHeadlinesUseCase() {
        // Given
        let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase?
        // When
        readTopHeadlinesUseCase = sut.readTopHeadlinesUseCase
        // Then
        #expect(readTopHeadlinesUseCase != nil,
                "ReadTopHeadlinesUseCase initializing failed!")
    }
}
