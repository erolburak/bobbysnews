//
//  StringExtensionsTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class StringExtensionsTests: XCTestCase {

	func testToDateIsNotNil() {
		// Given
		let dateString = "2001-02-03T12:34:56Z"
		// When
		let date = dateString.toDate
		// Then
		XCTAssertNotNil(date)
	}

	func testToDateIsNil() {
		// Given
		let dateString = "2001-02-03"
		// When
		let date = dateString.toDate
		// Then
		XCTAssertNil(date)
	}
}
