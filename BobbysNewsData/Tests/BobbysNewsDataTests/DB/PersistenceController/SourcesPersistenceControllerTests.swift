//
//  SourcesPersistenceControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Combine
import XCTest

class SourcesPersistenceControllerTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellables: Set<AnyCancellable>!
	private var entity: EntityMock!
	private var sut: SourcesPersistenceControllerMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellables = Set<AnyCancellable>()
		entity = EntityMock()
		sut = SourcesPersistenceControllerMock()
	}

	override func tearDownWithError() throws {
		cancellables.removeAll()
		entity = nil
		sut = nil
	}

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
	}

	func testFetchRequest() throws {
		// Given
		try sut.delete()
		// When
		sut.fetchRequest()
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.count, 1)
	}

	func testRead() async {
		// Given
		var sources: [SourceDB]?
		sut.queriesSubject.value = entity.sourcesDB
		// When
		let expectation = expectation(description: "Read")
		sut.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { newSources in
				sources = newSources
				expectation.fulfill()
			})
			.store(in: &cancellables)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(sources)
	}

	func testSave() throws {
		// Given
		let sourcesAPI = entity.sourcesAPI
		// When
		sut.save(sourcesAPI: sourcesAPI)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.count, 2)
	}
}
