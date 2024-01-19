//
//  SourcesQueriesRepositoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class SourcesQueriesRepositoryTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var mock: SourcesDataControllerMock!
	private var sut: SourcesQueriesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		mock = SourcesDataControllerMock()
		sut = SourcesQueriesRepositoryMock(sourcesDataController: mock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		mock = nil
		sut = nil
	}

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
		XCTAssertNil(mock.queriesSubject.value)
	}

	func testFetchRequest() {
		// When
		sut.fetchRequest()
		// Then
		XCTAssertEqual(mock.queriesSubject.value?.sources?.count, 2)
	}

	func testRead() async {
		// Given
		var sources: Sources?
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

	func testSave() {
		// Given
		let sourcesDto = DTOMock.sourcesDto2
		// When
		sut.save(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(mock.queriesSubject.value?.sources?.count, 4)
	}
}
