//
//  SourceDBExtensionTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsData
import Testing

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
        #expect(sourceDB.category == sourceAPI.category &&
            sourceDB.country == sourceAPI.country &&
            sourceDB.id == sourceAPI.id &&
            sourceDB.language == sourceAPI.language &&
            sourceDB.name == sourceAPI.name &&
            sourceDB.story == sourceAPI.story &&
            sourceDB.url == sourceAPI.url,
            "SourceDB initializing failed!")
    }
}
