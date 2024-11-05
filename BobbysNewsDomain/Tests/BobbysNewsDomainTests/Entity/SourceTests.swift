//
//  SourceTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import Foundation
import Testing

@Suite("Source tests")
struct SourceTests {
    // MARK: - Methods

    @Test("Check Source initializing!")
    func testSource() {
        // Given
        let source: Source?
        // When
        source = EntityMock.sources.sources?.first
        // Then
        #expect(source?.category == "Test" &&
            source?.country == "uk" &&
            source?.id == "Test" &&
            source?.language == "Test" &&
            source?.name == "Test" &&
            source?.story == "Test" &&
            source?.url == URL(string: "Test"),
            "Source initializing failed!")
    }
}
