//
//  TopHeadlinesNetworkControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

import Testing

@testable import BobbysNewsData

@Suite("TopHeadlinesNetworkController tests")
struct TopHeadlinesNetworkControllerTests {
    // MARK: - Private Properties

    private let sut = TopHeadlinesNetworkControllerMock()

    // MARK: - Methods

    @Test("Check TopHeadlinesNetworkController fetch!")
    func fetch() throws {
        // Given
        let apiKey = "Test"
        let category = "Test"
        let country = "Test"
        // When
        let topHeadlinesAPI = try sut.fetch(
            apiKey: apiKey,
            category: category,
            country: country
        )
        // Then
        #expect(
            topHeadlinesAPI.articles?.count == 1,
            "TopHeadlinesNetworkController fetch failed!"
        )
    }
}
