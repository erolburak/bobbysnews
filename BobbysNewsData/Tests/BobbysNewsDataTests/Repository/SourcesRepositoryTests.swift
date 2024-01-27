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
	private var sut: SourcesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sut = SourcesRepositoryMock()
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
	}

	func testDelete() async throws {
		// Given
		sut.sourcesPersistenceController.queriesSubject.value = EntityMock.sourcesDB
		// When
		try sut
			.delete()
		// Then
		XCTAssertNil(sut.sourcesPersistenceController.queriesSubject.value)
	}

	func testFetch() async throws {
		// Given
		let apiKey = 1
		// When
		try await sut.fetch(apiKey: apiKey)
		// Then
		XCTAssertEqual(sut.sourcesPersistenceController.queriesSubject.value?.count, 2)
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
