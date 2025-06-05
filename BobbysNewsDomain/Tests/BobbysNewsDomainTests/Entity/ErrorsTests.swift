//
//  ErrorsTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

@testable import BobbysNewsDomain
import Testing

@Suite("Errors tests")
struct ErrorsTests {
    // MARK: - Methods

    @Test("Check Errors initializing!")
    func errors() {
        for error in EntityMock.errors {
            // Given
            var newError: Error?
            // When
            newError = error
            // Then
            #expect(newError != nil,
                    "Error initializing failed!")
        }
    }
}
