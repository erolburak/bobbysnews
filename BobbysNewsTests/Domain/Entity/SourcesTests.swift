//
//  SourcesTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class SourcesTests: XCTestCase {

	func testSources() {
		// Given
		let sources: Sources?
		// When
		sources = Sources(sources: [Source(category: "Test",
										   country: "Test",
										   id: "Test",
										   language: "Test",
										   name: "Test",
										   story: "Test",
										   url: URL(string: "Test"))],
						  status: "Test")
		// Then
		XCTAssertNotNil(sources)
	}
}
