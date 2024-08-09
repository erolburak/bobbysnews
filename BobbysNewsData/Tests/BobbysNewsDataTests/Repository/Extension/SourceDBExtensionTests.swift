//
//  SourceDBExtensionTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsData
import XCTest

class SourceDBExtensionTests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
	}

	override func tearDownWithError() throws {
		entity = nil
	}

	func testSourceDB() {
		// Given
		let sourceAPI = entity.sourceAPI
		// When
		let sourceDB = SourceDB(from: sourceAPI)
		// Then
		XCTAssertEqual(sourceDB.category, sourceAPI.category)
		XCTAssertEqual(sourceDB.country, sourceAPI.country)
		XCTAssertEqual(sourceDB.id, sourceAPI.id)
		XCTAssertEqual(sourceDB.language, sourceAPI.language)
		XCTAssertEqual(sourceDB.name, sourceAPI.name)
		XCTAssertEqual(sourceDB.story, sourceAPI.story)
		XCTAssertEqual(sourceDB.url, sourceAPI.url)
	}
}
