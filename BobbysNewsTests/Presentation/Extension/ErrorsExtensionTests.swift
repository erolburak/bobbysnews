//
//  ErrorsExtensionTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 24.01.24.
//

@testable import BobbysNews
import XCTest

class ErrorsExtensionTests: XCTestCase {

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
