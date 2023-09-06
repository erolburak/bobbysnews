//
//  TopHeadlinesQueriesRepositoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class TopHeadlinesQueriesRepositoryTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var mock: TopHeadlinesDataControllerMock!
	private var sut: TopHeadlinesQueriesRepositoryMock!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		mock = TopHeadlinesDataControllerMock()
		sut = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: mock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		mock = nil
		sut = nil
	}

	// MARK: - Actions

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
		XCTAssertNil(mock.topHeadlinesQueriesSubject.value)
	}

	func testFetchRequest() {
		// Given
		let country = "Test 1"
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(mock.topHeadlinesQueriesSubject.value?.articles?.count, 1)
	}

	func testFetchRequestIsEmpty() {
		// Given
		let country = ""
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(mock.topHeadlinesQueriesSubject.value?.articles?.count, 0)
	}

	func testRead() async {
		// Given
		var topHeadlines: TopHeadlines?
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

	func testSave() {
		// Given
		let topHeadlinesDto = DTOMock.topHeadlinesDto2
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(mock.topHeadlinesQueriesSubject.value?.articles?.count, 4)
	}
}
