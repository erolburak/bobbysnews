//
//  SourceAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

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
        #expect(sourceAPI?.name == "Test" &&
            sourceAPI?.url == URL(string: "Test"),
            "SourceAPI initializing failed!")
    }
}
