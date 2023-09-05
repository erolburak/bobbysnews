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
		source = Source(category: "Test",
						country: "Test",
						id: "Test",
						language: "Test",
						name: "Test",
						story: "Test",
						url: URL(string: "Test"))
		// Then
		XCTAssertNotNil(source)
	}
}
