//
//  FetchSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class FetchSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var mock: SourcesRepositoryMock!
	private var sut: FetchSourcesUseCase!

	// MARK: - Actions

	override func setUpWithError() throws {
		mock = SourcesRepositoryMock()
		sut = FetchSourcesUseCase(sourcesRepository: mock)
	}

	override func tearDownWithError() throws {
		mock = nil
		sut = nil
	}

	func testFetch() async throws {
		// When
		let fetch: () = try await sut.fetch(apiKey: "Test")
		// Then
		XCTAssertNoThrow(fetch)
	}
}
