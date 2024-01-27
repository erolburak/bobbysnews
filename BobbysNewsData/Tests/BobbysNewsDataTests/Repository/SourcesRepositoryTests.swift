//
//  SourcesRepositoryTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Combine
import XCTest

class SourcesRepositoryTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var sourcesPersistenceControllerMock: SourcesPersistenceControllerMock!
	private var sourcesNetworkControllerMock: SourcesNetworkControllerMock!
	private var sut: SourcesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sourcesPersistenceControllerMock = SourcesPersistenceControllerMock()
		sourcesNetworkControllerMock = SourcesNetworkControllerMock()
		sut = SourcesRepositoryMock(sourcesPersistenceController: sourcesPersistenceControllerMock,
									sourcesNetworkController: sourcesNetworkControllerMock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sourcesPersistenceControllerMock = nil
		sourcesNetworkControllerMock = nil
		sut = nil
	}

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
		XCTAssertNil(sourcesPersistenceControllerMock.queriesSubject.value)
	}

	func testFetch() async throws {
		// Given
		let apiKey = 1
		// When
		try await sut.fetch(apiKey: apiKey)
		// Then
		XCTAssertEqual(sourcesPersistenceControllerMock.queriesSubject.value?.count, 1)
	}

	func testRead() async {
		// Given
		var sources: [SourceDB]?
		// When
		let expectation = expectation(description: "Read")
		sut.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { newSources in
				sources = newSources
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(sources)
	}
}
