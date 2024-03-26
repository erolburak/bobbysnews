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

	private var cancellables: Set<AnyCancellable>!
	private var sut: TopHeadlinesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellables = Set<AnyCancellable>()
		sut = TopHeadlinesRepositoryMock()
	}

	override func tearDownWithError() throws {
		cancellables.removeAll()
		sut = nil
	}

	func testDelete() async throws {
		// Given
		sut.topHeadlinesPersistenceController.queriesSubject.value = EntityMock.topHeadlinesDB
		// When
		try sut
			.delete(country: nil)
		// Then
		XCTAssertNil(sut.topHeadlinesPersistenceController.queriesSubject.value)
	}

	func testFetch() async throws {
		// Given
		let apiKey = 1
		let country = "Test"
		// When
		try await sut.fetch(apiKey: apiKey,
							country: country)
		// Then
		XCTAssertEqual(sut.topHeadlinesPersistenceController.queriesSubject.value?.count, 2)
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
			.store(in: &cancellables)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(topHeadlines)
	}
}
