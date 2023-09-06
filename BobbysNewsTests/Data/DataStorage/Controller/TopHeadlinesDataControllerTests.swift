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
		let country = "Test"
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
		sut.topHeadlinesQueriesSubject.value = TopHeadlines(articles: nil,
															status: nil,
															totalResults: nil)
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
		sut.topHeadlinesSourcesQueriesSubject.value = Sources(sources: nil,
															  status: nil)
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

	func testSave() {
		// Given
		let topHeadlinesDto = DTOMock.topHeadlinesDto
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(sut.topHeadlinesQueriesSubject.value?.articles?.count, 2)
	}

	func testSaveSources() {
		// Given
		let sourcesDto = DTOMock.sourcesDto
		// When
		sut.saveSources(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(sut.topHeadlinesSourcesQueriesSubject.value?.sources?.count, 4)
	}
}
