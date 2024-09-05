//
//  SourceAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

struct SourceAPITests {
    // MARK: - Methods

    @Test("Check SourceAPI initializing!")
    func testSourceAPI() {
        // Given
        let sourceAPI: SourceAPI?
        // When
        sourceAPI = EntityMock.sourceAPI
        // Then
        #expect(sourceAPI?.category == "Test" &&
            sourceAPI?.country == "en-gb" &&
            sourceAPI?.id == "Test" &&
            sourceAPI?.language == "Test" &&
            sourceAPI?.name == "Test" &&
            sourceAPI?.story == "Test" &&
            sourceAPI?.url == URL(string: "Test"),
            "SourceAPI initializing failed!")
    }
}
