//
//  SourcesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class SourcesTests: XCTestCase {

	// MARK: - Actions

	func testSources() {
		// Given
		let sources: Sources?
		// When
		sources = EntityMock.sources
		// Then
		XCTAssertEqual(sources?.sources?.first?.category, "Test")
		XCTAssertEqual(sources?.sources?.first?.country, "Test")
		XCTAssertEqual(sources?.sources?.first?.id, "Test")
		XCTAssertEqual(sources?.sources?.first?.language, "Test")
		XCTAssertEqual(sources?.sources?.first?.name, "Test")
		XCTAssertEqual(sources?.sources?.first?.story, "Test")
		XCTAssertEqual(sources?.sources?.first?.url, URL(string: "Test"))
	}
}
