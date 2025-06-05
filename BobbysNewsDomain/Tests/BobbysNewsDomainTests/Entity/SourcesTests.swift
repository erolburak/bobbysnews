//
//  SourcesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

@Suite("Sources tests")
struct SourcesTests {
    // MARK: - Methods

    @Test("Check Sources initializing!")
    func sources() {
        // Given
        let sources: Sources?
        // When
        sources = EntityMock.sources
        // Then
        #expect(sources?.sources?.first?.category == "Test" &&
            sources?.sources?.first?.country == "uk" &&
            sources?.sources?.first?.id == "Test" &&
            sources?.sources?.first?.language == "Test" &&
            sources?.sources?.first?.name == "Test" &&
            sources?.sources?.first?.story == "Test" &&
            sources?.sources?.first?.url == URL(string: "Test"),
            "Sources initializing failed!")
    }
}
