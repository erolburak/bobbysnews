//
//  SourceDBExtensionTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsData
import Testing

struct SourceDBExtensionTests {

	// MARK: - Actions

	@Test("Check initializing SourceDB!")
	func testSourceDB() {
		// Given
		let sourceAPI = EntityMock.sourceAPI
		// When
		let sourceDB = SourceDB(from: sourceAPI)
		// Then
		#expect(sourceDB.category == sourceAPI.category,
				"Initializing SourceDB sourceDB.category failed!")
		#expect(sourceDB.country == sourceAPI.country,
				"Initializing SourceDB sourceDB.country failed!")
		#expect(sourceDB.id == sourceAPI.id,
				"Initializing SourceDB sourceDB.id failed!")
		#expect(sourceDB.language == sourceAPI.language,
				"Initializing SourceDB sourceDB.language failed!")
		#expect(sourceDB.name == sourceAPI.name,
				"Initializing SourceDB sourceDB.name failed!")
		#expect(sourceDB.story == sourceAPI.story,
				"Initializing SourceDB sourceDB.story failed!")
		#expect(sourceDB.url == sourceAPI.url,
				"Initializing SourceDB sourceDB.url failed!")
	}
}
