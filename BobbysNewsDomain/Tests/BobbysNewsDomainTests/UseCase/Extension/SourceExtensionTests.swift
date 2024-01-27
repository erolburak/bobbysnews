//
//  SourceExtensionTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsDomain
import XCTest

class SourceExtensionTests: XCTestCase {

	// MARK: - Actions

	func testSource() {
		// Given
		let sourceDB = EntityMock.sourceDB
		// When
		let source = Source(from: sourceDB)
		// Then
		XCTAssertEqual(source?.category, sourceDB.category)
		XCTAssertEqual(source?.country, sourceDB.country)
		XCTAssertEqual(source?.id, sourceDB.id)
		XCTAssertEqual(source?.language, sourceDB.language)
		XCTAssertEqual(source?.name, sourceDB.name)
		XCTAssertEqual(source?.story, sourceDB.story)
		XCTAssertEqual(source?.url, sourceDB.url)
	}
}
