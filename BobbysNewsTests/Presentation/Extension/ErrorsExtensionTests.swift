//
//  ErrorsExtensionTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 24.01.24.
//

@testable import BobbysNews
import XCTest

class ErrorsExtensionTests: XCTestCase {

	// MARK: - Actions

	func testErrors() {
		for error in EntityMock.errors {
			// Given
			let description: String?
			let recoverySuggestion: String?
			// When
			description = error.errorDescription
			recoverySuggestion = error.recoverySuggestion
			// Then
			XCTAssertNotNil(description)
			XCTAssertNotNil(recoverySuggestion)
		}
	}
}
