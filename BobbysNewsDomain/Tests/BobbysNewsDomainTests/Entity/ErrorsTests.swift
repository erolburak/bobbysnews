//
//  ErrorsTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

@testable import BobbysNewsDomain
import XCTest

class ErrorsTests: XCTestCase {

	// MARK: - Actions

	func testErrors() {
		for error in EntityMock.errors {
			// Given
			var newError: Error?
			// When
			newError = error
			// Then
			XCTAssertNotNil(newError)
		}
	}
}
