//
//  TopHeadlinesPersistenceControllerTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsData
import Combine
import XCTest

class TopHeadlinesPersistenceControllerTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellables: Set<AnyCancellable>!
	private var sut: TopHeadlinesPersistenceControllerMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellables = Set<AnyCancellable>()
		sut = TopHeadlinesPersistenceControllerMock()
	}

	override func tearDownWithError() throws {
		cancellables.removeAll()
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
		XCTAssertEqual(sut.queriesSubject.value?.count, 0)
	}

	func testRead() async {
		// Given
		var topHeadlines: [ArticleDB]?
		sut.queriesSubject.value = EntityMock.topHeadlinesDB
		// When
		let expectation = expectation(description: "Read")
		sut.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { newTopHeadlines in
				topHeadlines = newTopHeadlines
				expectation.fulfill()
			})
			.store(in: &cancellables)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(topHeadlines)
	}

	func testSave() throws {
		// Given
		let topHeadlinesAPI = EntityMock.topHeadlinesAPI
		// When
		sut.save(country: "Test",
				 topHeadlinesAPI: topHeadlinesAPI)
		// Then
		XCTAssertEqual(sut.queriesSubject.value?.count, 2)
	}
}
