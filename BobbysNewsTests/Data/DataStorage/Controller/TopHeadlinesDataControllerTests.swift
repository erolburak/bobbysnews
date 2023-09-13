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
		XCTAssertNoThrow(try sut.delete(country: nil))
	}

	func testFetchRequest() {
		// Given
		let country = ""
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.articles?.count, 0)
	}

	func testRead() async {
		// Given
		var topHeadlines: TopHeadlines?
		sut.queriesSubject.value = EntityMock.topHeadlines1
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

	func testSaveWithExistingTopHeadlines() throws {
		// Given
		try sut.delete(country: nil)
		let topHeadlinesDto = DTOMock.topHeadlinesDto1
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.articles?.count, 2)
	}

	func testSaveWithNewTopHeadlines() {
		// Given
		let topHeadlinesDto = DTOMock.topHeadlinesDto2
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.articles?.count, 4)
	}
}
