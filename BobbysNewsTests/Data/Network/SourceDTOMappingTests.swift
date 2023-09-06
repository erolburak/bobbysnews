//
//  SourceDTOMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class SourceDTOMappingTests: XCTestCase {

	// MARK: - Actions

	func testToDomain() {
		// Given
		let sourceDto = DTOMock.sourceDto
		// When
		let source = sourceDto.toDomain()
		// Then
		XCTAssertEqual(source?.category, sourceDto.category)
		XCTAssertEqual(source?.country, sourceDto.country)
		XCTAssertEqual(source?.id, sourceDto.id)
		XCTAssertEqual(source?.language, sourceDto.language)
		XCTAssertEqual(source?.name, sourceDto.name)
		XCTAssertEqual(source?.story, sourceDto.story)
		XCTAssertNotNil(source?.url)
	}

	func testToEntity() {
		// Given
		let sourceDto = DTOMock.sourceDto
		// When
		let sourceEntity = sourceDto.toEntity(in: DataController.shared.backgroundContext)
		// Then
		XCTAssertEqual(sourceEntity?.category, sourceDto.category)
		XCTAssertEqual(sourceEntity?.country, sourceDto.country)
		XCTAssertEqual(sourceEntity?.id, sourceDto.id)
		XCTAssertEqual(sourceEntity?.language, sourceDto.language)
		XCTAssertEqual(sourceEntity?.name, sourceDto.name)
		XCTAssertEqual(sourceEntity?.story, sourceDto.story)
		XCTAssertNotNil(sourceEntity?.url)
	}
}
