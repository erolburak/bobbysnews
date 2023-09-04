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

	private var cancellable: Set<AnyCancellable>!
	private var mock: TopHeadlinesDataControllerMock!
	private var sut: TopHeadlinesQueriesRepositoryMock!

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

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
		XCTAssertNil(mock.topHeadlinesQueriesSubject.value)
	}

	func testFetchRequestWithCountryGermany() {
		// Given
		let country = Country.germany
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(mock.topHeadlinesQueriesSubject.value?.articles?.count, 2)
	}

	func testFetchRequestWithCountryNoneIsEmpty() {
		// Given
		let country = Country.none
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
		let topHeadlinesDto = TopHeadlinesDTO(articles: [ArticleDTO(author: "Test 3",
																	content: "Test 3",
																	publishedAt: "Test 3",
																	source: SourceDTO(id: "Test 3",
																					  name: "Test 3"),
																	story: "Test 3",
																	title: "Test 3",
																	url: URL(string: "Test 3"),
																	urlToImage: URL(string: "Test 3")),
														 ArticleDTO(author: "Test 4",
																	content: "Test 4",
																	publishedAt: "Test 4",
																	source: SourceDTO(id: "Test 4",
																					  name: "Test 4"),
																	story: "Test 4",
																	title: "Test 4",
																	url: URL(string: "Test 4"),
																	urlToImage: URL(string: "Test 4"))],
											  status: "Test",
											  totalResults: 2)
		// When
		sut.save(country: .germany,
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(mock.topHeadlinesQueriesSubject.value?.articles?.count, 4)
	}
}
