//
//  SourcesDTOMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class SourcesDTOMappingTests: XCTestCase {

	// MARK: - Actions

	func testToDomain() {
		// Given
		let sourcesDto = DTOMock.sourcesDto1
		// When
		let sources = sourcesDto.toDomain()
		// Then
		XCTAssertEqual(sources?.sources?.count, sourcesDto.sources?.count)
		XCTAssertEqual(sources?.status, sourcesDto.status)
	}
}
