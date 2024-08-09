//
//  SourcesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class SourcesTests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
	}

	override func tearDownWithError() throws {
		entity = nil
	}

	func testSources() {
		// Given
		let sources: Sources?
		// When
		sources = entity.sources
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
