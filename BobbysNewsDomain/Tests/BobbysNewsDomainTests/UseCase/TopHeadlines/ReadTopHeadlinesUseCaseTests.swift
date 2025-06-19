//
//  ReadTopHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import BobbysNewsData
import Testing

@testable import BobbysNewsDomain

@Suite("ReadApiHeadlinesUseCase tests")
struct ReadApiHeadlinesUseCaseTests {
    // MARK: - Private Properties

    private let sut = ReadTopHeadlinesUseCase(topHeadlinesRepository: TopHeadlinesRepositoryMock())

    // MARK: - Methods

    @Test("Check ReadTopHeadlinesUseCase read!")
    func read() throws {
        // Given
        let category = "Test"
        let country = "Test"
        var topHeadlines: TopHeadlines?
        // When
        topHeadlines = try sut.read(
            category: category,
            country: country
        )
        // Then
        #expect(
            topHeadlines?.articles?.count == 1,
            "ReadTopHeadlinesUseCase read failed!"
        )
    }
}
