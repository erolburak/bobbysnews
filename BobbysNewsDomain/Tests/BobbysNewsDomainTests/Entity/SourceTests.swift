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
    func source() {
        // Given
        let source: Source?
        // When
        source = EntityMock.topHeadlines.articles?.first?.source
        // Then
        #expect(source?.name == "Test" &&
            source?.url == URL(string: "Test"),
            "Source initializing failed!")
    }
}
