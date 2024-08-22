//
//  SourcesAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

struct SourcesAPITests {
    // MARK: - Methods

    @Test("Check SourcesAPI initializing!")
    func testSourcesAPI() {
        // Given
        let sourcesAPI: SourcesAPI?
        // When
        sourcesAPI = EntityMock.sourcesAPI
        // Then
        #expect(sourcesAPI?.sources?.first?.category == "Test" &&
            sourcesAPI?.sources?.first?.country == "Test" &&
            sourcesAPI?.sources?.first?.id == "Test" &&
            sourcesAPI?.sources?.first?.language == "Test" &&
            sourcesAPI?.sources?.first?.name == "Test" &&
            sourcesAPI?.sources?.first?.story == "Test" &&
            sourcesAPI?.sources?.first?.url == URL(string: "Test"),
            "SourcesAPI initializing failed!")
    }
}
