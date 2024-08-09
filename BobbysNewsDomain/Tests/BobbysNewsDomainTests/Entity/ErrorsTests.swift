//
//  ErrorsTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

@testable import BobbysNewsDomain
import XCTest

class ErrorsTests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
	}

	override func tearDownWithError() throws {
		entity = nil
	}

	func testErrors() {
		for error in entity.errors {
			// Given
			var newError: Error?
			// When
			newError = error
			// Then
			XCTAssertNotNil(newError)
		}
	}
}
