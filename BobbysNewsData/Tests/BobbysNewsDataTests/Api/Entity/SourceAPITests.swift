//
//  SourceAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

import Foundation
import Testing

@testable import BobbysNewsData

@Suite("SourceAPI tests")
struct SourceAPITests {
    // MARK: - Methods

    @Test("Check SourceAPI initializing!")
    func sourceAPI() {
        // Given
        let sourceAPI: SourceAPI?
        // When
        sourceAPI = EntityMock.sourceAPI
        // Then
        #expect(
            sourceAPI?.name == "Test" && sourceAPI?.url == URL(string: "Test"),
            "SourceAPI initializing failed!"
        )
    }
}
