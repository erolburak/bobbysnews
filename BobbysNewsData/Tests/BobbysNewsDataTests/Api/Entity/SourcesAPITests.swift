//
//  SourcesAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsData
import XCTest

class SourcesAPITests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
	}

	override func tearDownWithError() throws {
		entity = nil
	}

	// MARK: - Actions

	func testSourcesAPI() {
		// Given
		let sourcesAPI: SourcesAPI?
		// When
		sourcesAPI = entity.sourcesAPI
		// Then
		XCTAssertEqual(sourcesAPI?.sources?.first?.category, "Test")
		XCTAssertEqual(sourcesAPI?.sources?.first?.country, "Test")
		XCTAssertEqual(sourcesAPI?.sources?.first?.id, "Test")
		XCTAssertEqual(sourcesAPI?.sources?.first?.language, "Test")
		XCTAssertEqual(sourcesAPI?.sources?.first?.name, "Test")
		XCTAssertEqual(sourcesAPI?.sources?.first?.story, "Test")
		XCTAssertEqual(sourcesAPI?.sources?.first?.url, URL(string: "Test"))
	}
}
