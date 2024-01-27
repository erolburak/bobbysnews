//
//  TopHeadlinesRepositoryTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Combine
import XCTest

class TopHeadlinesRepositoryTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var topHeadlinesPersistenceControllerMock: TopHeadlinesPersistenceControllerMock!
	private var topHeadlinesNetworkControllerMock: TopHeadlinesNetworkControllerMock!
	private var sut: TopHeadlinesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		topHeadlinesPersistenceControllerMock = TopHeadlinesPersistenceControllerMock()
		topHeadlinesNetworkControllerMock = TopHeadlinesNetworkControllerMock()
		sut = TopHeadlinesRepositoryMock(topHeadlinesPersistenceController: topHeadlinesPersistenceControllerMock,
										 topHeadlinesNetworkController: topHeadlinesNetworkControllerMock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		topHeadlinesPersistenceControllerMock = nil
		topHeadlinesNetworkControllerMock = nil
		sut = nil
	}

	func testDelete() {
		XCTAssertNoThrow(try sut.delete(country: nil))
		XCTAssertNil(topHeadlinesPersistenceControllerMock.queriesSubject.value)
	}

	func testFetch() async throws {
		// Given
		let apiKey = 1
		let country = "Test"
		// When
		try await sut.fetch(apiKey: apiKey,
							country: country)
		// Then
		XCTAssertEqual(topHeadlinesPersistenceControllerMock.queriesSubject.value?.count, 1)
	}

	func testRead() async {
		// Given
		var topHeadlines: [ArticleDB]?
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
}
