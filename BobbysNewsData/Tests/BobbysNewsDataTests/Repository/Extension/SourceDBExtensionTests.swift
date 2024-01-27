//
//  SourceDBExtensionTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsData
import XCTest

class SourceDBExtensionTests: XCTestCase {

	// MARK: - Actions

	func testSourceDB() {
		// Given
		let sourceAPI = EntityMock.sourceAPI
		// When
		let sourceDB = SourceDB(from: sourceAPI)
		// Then
		XCTAssertEqual(sourceDB?.category, sourceAPI.category)
		XCTAssertEqual(sourceDB?.country, sourceAPI.country)
		XCTAssertEqual(sourceDB?.id, sourceAPI.id)
		XCTAssertEqual(sourceDB?.language, sourceAPI.language)
		XCTAssertEqual(sourceDB?.name, sourceAPI.name)
		XCTAssertEqual(sourceDB?.story, sourceAPI.story)
		XCTAssertEqual(sourceDB?.url, sourceAPI.url)
	}
}
