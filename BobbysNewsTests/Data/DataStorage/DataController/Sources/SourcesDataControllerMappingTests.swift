//
//  SourcesDataControllerMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 23.01.24.
//

@testable import BobbysNews
import XCTest

class SourcesDataControllerMappingTests: XCTestCase {

	// MARK: - Actions

	func testSource() {
		// Given
		let sourceEntity = EntityMock.sourceEntity1
		// When
		let source = Source(from: sourceEntity)
		// Then
		XCTAssertEqual(source?.category, sourceEntity.category)
		XCTAssertEqual(source?.country, sourceEntity.country)
		XCTAssertEqual(source?.id, sourceEntity.id)
		XCTAssertEqual(source?.language, sourceEntity.language)
		XCTAssertEqual(source?.name, sourceEntity.name)
		XCTAssertEqual(source?.story, sourceEntity.story)
		XCTAssertNotNil(source?.url)
	}

	func testSourceEntity() {
		// Given
		let sourceApi = ApiMock.sourceApi1
		// When
		let sourceEntity = SourceEntity(from: sourceApi,
										in: DataController.shared.backgroundContext)
		// Then
		XCTAssertEqual(sourceEntity?.category, sourceApi.category)
		XCTAssertEqual(sourceEntity?.country, sourceApi.country)
		XCTAssertEqual(sourceEntity?.id, sourceApi.id)
		XCTAssertEqual(sourceEntity?.language, sourceApi.language)
		XCTAssertEqual(sourceEntity?.name, sourceApi.name)
		XCTAssertEqual(sourceEntity?.story, sourceApi.story)
		XCTAssertNotNil(sourceEntity?.url)
	}
}
