//
//  SourceDTOMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class SourceDTOMappingTests: XCTestCase {

	func testToDomain() {
		// Given
		let sourceDto = SourceDTO(id: "Test",
								  name: "Test")
		// When
		let source = sourceDto.toDomain()
		// Then
		XCTAssertEqual(source.id, sourceDto.id)
		XCTAssertEqual(source.name, sourceDto.name)
	}
}
