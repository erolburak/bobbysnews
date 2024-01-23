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

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sut = TopHeadlinesDataController()
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
	}

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
		sut.queriesSubject.value = EntityMock.topHeadlinesEntity
		// When
		let expectation = expectation(description: "Read")
		sut.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { newTopHeadlines in
				topHeadlines = newTopHeadlines
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
		let topHeadlinesApi = ApiMock.topHeadlinesApi1
		// When
		sut.save(country: "Test",
				 topHeadlinesApi: topHeadlinesApi)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.articles?.count, 2)
	}

	func testSaveWithNewTopHeadlines() {
		// Given
		let topHeadlinesApi = ApiMock.topHeadlinesApi2
		// When
		sut.save(country: "Test",
				 topHeadlinesApi: topHeadlinesApi)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.articles?.count, 4)
	}
}
