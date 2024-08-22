//
//  ReadTopHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import BobbysNewsData
@testable import BobbysNewsDomain
import Testing

struct ReadApiHeadlinesUseCaseTests {
    // MARK: - Private Properties

    private let sut = ReadTopHeadlinesUseCase(topHeadlinesRepository: TopHeadlinesRepositoryMock())

    // MARK: - Methods

    @Test("Check ReadTopHeadlinesUseCase read!")
    func testRead() throws {
        // Given
        let country = "Test"
        var topHeadlines: TopHeadlines?
        // When
        topHeadlines = try sut.read(country: country)
        // Then
        #expect(topHeadlines?.articles?.count == 1,
                "ReadTopHeadlinesUseCase read failed!")
    }
}
