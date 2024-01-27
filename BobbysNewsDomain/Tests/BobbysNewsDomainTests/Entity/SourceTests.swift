//
//  SourceTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class SourceTests: XCTestCase {

	// MARK: - Actions

	func testSource() {
		// Given
		let source: Source?
		// When
		source = EntityMock.source
		// Then
		XCTAssertEqual(source?.category, "Test")
		XCTAssertEqual(source?.country, "Test")
		XCTAssertEqual(source?.id, "Test")
		XCTAssertEqual(source?.language, "Test")
		XCTAssertEqual(source?.name, "Test")
		XCTAssertEqual(source?.story, "Test")
		XCTAssertEqual(source?.url, URL(string: "Test"))
	}
}
