//
//  TopHeadlinesDataControllerTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class TopHeadlinesDataControllerTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var sut: TopHeadlinesDataController!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sut = TopHeadlinesDataController()
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
	}

	// MARK: - Actions

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
	}

	func testFetchRequest() {
		// Given
		let country = ""
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(sut.topHeadlinesQueriesSubject.value?.articles?.count, 0)
	}

	func testFetchSourcesRequest() {
		// When
		sut.fetchSourcesRequest()
		// Then
		XCTAssertEqual(sut.topHeadlinesSourcesQueriesSubject.value?.sources?.count, 0)
	}

	func testRead() async {
		// Given
		var topHeadlines: TopHeadlines?
		sut.topHeadlinesQueriesSubject.value = EntityMock.topHeadlines1
		// When
		let expectation = expectation(description: "Read")
		sut.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: {
				topHeadlines = $0
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(topHeadlines)
	}

	func testReadSources() async {
		// Given
		var sources: Sources?
		sut.topHeadlinesSourcesQueriesSubject.value = EntityMock.sources1
		// When
		let expectation = expectation(description: "ReadSources")
		sut.readSources()
			.sink(receiveCompletion: { _ in },
				  receiveValue: {
				sources = $0
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(sources)
	}

	func testSaveWithExistingTopHeadlines() {
		// Given
		let topHeadlinesDto = DTOMock.topHeadlinesDto1
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(sut.topHeadlinesQueriesSubject.value?.articles?.count, 2)
	}

	func testSaveWithNewTopHeadlines() {
		// Given
		let topHeadlinesDto = DTOMock.topHeadlinesDto2
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(sut.topHeadlinesQueriesSubject.value?.articles?.count, 4)
	}

	func testSaveSourcesWithExistingSources() {
		// Given
		let sourcesDto = DTOMock.sourcesDto1
		// When
		sut.saveSources(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(sut.topHeadlinesSourcesQueriesSubject.value?.sources?.count, 2)
	}

	func testSaveSourcesWithNewSources() {
		// Given
		let sourcesDto = DTOMock.sourcesDto2
		// When
		sut.saveSources(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(sut.topHeadlinesSourcesQueriesSubject.value?.sources?.count, 4)
	}
}
