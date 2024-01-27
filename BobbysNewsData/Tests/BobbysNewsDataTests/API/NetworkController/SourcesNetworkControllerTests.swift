//
//  SourcesNetworkControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import XCTest

class SourcesNetworkControllerTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: SourcesNetworkControllerMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		sut = SourcesNetworkControllerMock()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testFetch() async throws {
		// Given
		let apiKey = 1
		// When
		let sourcesAPI = try await sut
			.fetch(apiKey: apiKey)
		// Then
		XCTAssertEqual(sourcesAPI.sources?.count, 1)
	}
}
