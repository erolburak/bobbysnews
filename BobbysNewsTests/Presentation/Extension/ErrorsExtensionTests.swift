//
//  ErrorsExtensionTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 24.01.24.
//

import Testing

struct ErrorsExtensionTests {
    // MARK: - Methods

    @Test("Check initializing Errors!")
    func testErrors() {
        for error in EntityMock.errors {
            // Given
            let description: String?
            let recoverySuggestion: String?
            // When
            description = error.errorDescription
            recoverySuggestion = error.recoverySuggestion
            // Then
            #expect(description != nil &&
                recoverySuggestion != nil,
                "Error initializing failed!")
        }
    }
}
