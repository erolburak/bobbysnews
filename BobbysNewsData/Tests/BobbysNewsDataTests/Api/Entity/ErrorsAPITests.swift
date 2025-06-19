//
//  ErrorsAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.06.25.
//

import Testing

@testable import BobbysNewsData

@Suite("ErrorsAPI tests")
struct ErrorsAPITests {
    // MARK: - Methods

    @Test("Check ErrorsAPI initializing!")
    func errorsAPI() {
        for errorAPI in EntityMock.errorsAPI {
            // Given
            var newErrorAPI: Error?
            // When
            newErrorAPI = errorAPI
            // Then
            #expect(
                newErrorAPI != nil,
                "ErrorAPI initializing failed!"
            )
        }
    }
}
