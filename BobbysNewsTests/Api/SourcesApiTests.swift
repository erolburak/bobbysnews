//
//  SourcesApiTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class SourcesApiTests: XCTestCase {

	// MARK: - Actions

	func testSourcesApi() {
		// Given
		let sourcesApi: SourcesApi?
		// When
		sourcesApi = SourcesApi(sources: [SourceApi(category: "Test",
													country: "Test",
													id: "Test",
													language: "Test",
													name: "Test",
													story: "Test",
													url: URL(string: "Test"))],
								status: "Test")
		// Then
		XCTAssertNotNil(sourcesApi)
	}
}
