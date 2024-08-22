//
//  SourcesNetworkControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Testing

struct SourcesNetworkControllerTests {
    // MARK: - Private Properties

    private let sut = SourcesNetworkControllerMock()

    // MARK: - Methods

    @Test("Check SourcesNetworkController fetch!")
    func testFetch() {
        // Given
        let apiKey = 1
        // When
        let sourcesAPI = sut.fetch(apiKey: apiKey)
        // Then
        #expect(sourcesAPI.sources?.count == 1,
                "SourcesNetworkController fetch failed!")
    }
}
