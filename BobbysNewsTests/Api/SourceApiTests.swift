//
//  SourceApiTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class SourceApiTests: XCTestCase {
    // MARK: - Actions

    func testSourceApi() {
        // Given
        let sourceApi: SourceApi?
        // When
        sourceApi = SourceApi(category: "Test",
                              country: "Test",
                              id: "Test",
                              language: "Test",
                              name: "Test",
                              story: "Test",
                              url: URL(string: "Test"))
        // Then
        XCTAssertNotNil(sourceApi)
    }
}
