//
//  SourceTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import Foundation
import Testing

@testable import BobbysNewsDomain

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
        #expect(
            source?.name == "Test" && source?.url == URL(string: "Test"),
            "Source initializing failed!"
        )
    }
}
