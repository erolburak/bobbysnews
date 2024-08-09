//
//  SourceTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class SourceTests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
	}

	override func tearDownWithError() throws {
		entity = nil
	}

	func testSource() {
		// Given
		let source: Source?
		// When
		source = entity.source
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
