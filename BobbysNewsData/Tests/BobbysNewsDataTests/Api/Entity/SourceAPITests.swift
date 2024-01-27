//
//  SourceAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import XCTest

class SourceAPITests: XCTestCase {

	// MARK: - Actions

	func testSourceAPI() {
		// Given
		let sourceAPI: SourceAPI?
		// When
		sourceAPI = EntityMock.sourceAPI
		// Then
		XCTAssertEqual(sourceAPI?.category, "Test")
		XCTAssertEqual(sourceAPI?.country, "Test")
		XCTAssertEqual(sourceAPI?.id, "Test")
		XCTAssertEqual(sourceAPI?.language, "Test")
		XCTAssertEqual(sourceAPI?.name, "Test")
		XCTAssertEqual(sourceAPI?.story, "Test")
		XCTAssertEqual(sourceAPI?.url, URL(string: "Test"))
	}
}
