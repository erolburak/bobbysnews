//
//  SourcesDTOMappingTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class SourcesDTOMappingTests: XCTestCase {

	func testToDomain() {
		// Given
		let sourcesDto = SourcesDTO(sources: [SourceDTO(category: "Test",
														country: "Test",
														id: "Test",
														language: "Test",
														name: "Test",
														story: "Test",
														url: URL(string: "Test"))],
									status: "Test")
		// When
		let sources = sourcesDto.toDomain()
		// Then
		XCTAssertEqual(sources?.sources?.count, sourcesDto.sources?.count)
		XCTAssertEqual(sources?.status, sourcesDto.status)
	}
}
