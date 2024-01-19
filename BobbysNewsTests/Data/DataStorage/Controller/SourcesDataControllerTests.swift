//
//  SourcesDataControllerTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class SourcesDataControllerTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var sut: SourcesDataController!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sut = SourcesDataController()
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
	}

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
	}

	func testFetchRequest() {
		// When
		sut.fetchRequest()
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.sources?.count, 0)
	}

	func testRead() async {
		// Given
		var sources: Sources?
		sut.queriesSubject.value = EntityMock.sources1
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

	func testSaveSourcesWithExistingSources() throws {
		// Given
		try sut.delete()
		let sourcesDto = DTOMock.sourcesDto1
		// When
		sut.save(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.sources?.count, 2)
	}

	func testSaveSourcesWithNewSources() {
		// Given
		let sourcesDto = DTOMock.sourcesDto2
		// When
		sut.save(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.sources?.count, 4)
	}
}
