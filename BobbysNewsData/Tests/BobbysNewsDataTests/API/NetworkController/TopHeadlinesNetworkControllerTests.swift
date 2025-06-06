//
//  TopHeadlinesNetworkControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Testing

@Suite("TopHeadlinesNetworkController tests")
struct TopHeadlinesNetworkControllerTests {
    // MARK: - Private Properties

    private let sut = TopHeadlinesNetworkControllerMock()

    // MARK: - Methods

    @Test("Check TopHeadlinesNetworkController fetch!")
    func fetch() throws {
        // Given
        let apiKey = 1
        let country = "uk"
        // When
        let topHeadlinesAPI = try sut.fetch(apiKey: apiKey,
                                            country: country)
        // Then
        #expect(topHeadlinesAPI.articles?.count == 1,
                "TopHeadlinesNetworkController fetch failed!")
    }
}
