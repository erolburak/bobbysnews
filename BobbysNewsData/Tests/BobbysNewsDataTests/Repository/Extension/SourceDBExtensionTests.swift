//
//  SourceDBExtensionTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

import Testing

@testable import BobbysNewsData

@Suite("SourceDBExtension tests")
struct SourceDBExtensionTests {
    // MARK: - Methods

    @Test("Check SourceDB initializing!")
    func sourceDB() {
        // Given
        let sourceAPI = EntityMock.sourceAPI
        // When
        let sourceDB = SourceDB(from: sourceAPI)
        // Then
        #expect(
            sourceDB.name == sourceAPI.name && sourceDB.url == sourceAPI.url,
            "SourceDB initializing failed!"
        )
    }
}
