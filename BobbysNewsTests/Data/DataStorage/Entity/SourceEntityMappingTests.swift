//
//  SourceEntityMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class SourceEntityMappingTests: XCTestCase {

	func testSourceEntity() {
		// Given
		let sourceEntity: SourceEntity?
		// When
		sourceEntity = SourceEntity(context: DataController.shared.backgroundContext)
		sourceEntity?.category = "Test"
		sourceEntity?.country = "Test"
		sourceEntity?.id = "Test"
		sourceEntity?.language = "Test"
		sourceEntity?.name = "Test"
		sourceEntity?.story = "Test"
		sourceEntity?.url = URL(string: "Test")
		// Then
		XCTAssertNotNil(sourceEntity)
	}

	func testToDomain() {
		// Given
		let sourceEntity = SourceEntity(context: DataController.shared.backgroundContext)
		sourceEntity.category = "Test"
		sourceEntity.country = "Test"
		sourceEntity.id = "Test"
		sourceEntity.language = "Test"
		sourceEntity.name = "Test"
		sourceEntity.story = "Test"
		sourceEntity.url = URL(string: "Test")
		// When
		let sourceDomain = sourceEntity.toDomain()
		// Then
		XCTAssertEqual(sourceDomain?.category, sourceEntity.category)
		XCTAssertEqual(sourceDomain?.country, sourceEntity.country)
		XCTAssertEqual(sourceDomain?.id, sourceEntity.id)
		XCTAssertEqual(sourceDomain?.language, sourceEntity.language)
		XCTAssertEqual(sourceDomain?.name, sourceEntity.name)
		XCTAssertEqual(sourceDomain?.story, sourceEntity.story)
	}
}
