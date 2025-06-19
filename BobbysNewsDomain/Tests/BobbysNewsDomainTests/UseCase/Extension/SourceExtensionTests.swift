//
//  SourceExtensionTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

import Foundation
import Testing

@testable import BobbysNewsDomain

@Suite("SourceExtension tests")
struct SourceExtensionTests {
    // MARK: - Methods

    @Test("Check SourceExtension Source initializing!")
    func source() {
        // Given
        var entity = EntityMock()
        let sourceDB = entity.sourceDB
        // When
        let source = Source(from: sourceDB)
        // Then
        #expect(
            source?.name == "Test" && source?.url == URL(string: "Test"),
            "SourceExtension Source initializing failed!"
        )
    }
}
