//
//  SourceTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class SourceTests: XCTestCase {

	func testSource() {
		// Given
		let source: Source?
		// When
		source = Source(id: "Test",
						name: "Test")
		// Then
		XCTAssertNotNil(source)
	}
}
