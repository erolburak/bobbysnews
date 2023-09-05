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

	private var cancellable: Set<AnyCancellable>!
	private var sut: TopHeadlinesDataController!

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sut = TopHeadlinesDataController()
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
	}

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
		let topHeadlinesDto = TopHeadlinesDTO(articles: [ArticleDTO(author: "Test 1",
																	content: "Test 1",
																	publishedAt: "Test 1",
																	source: SourceDTO(category: "Test 1",
																					  country: "Test 1",
																					  id: "Test 1",
																					  language: "Test 1",
																					  name: "Test 1",
																					  story: "Test 1",
																					  url: URL(string: "Test 1")),
																	story: "Test 1",
																	title: "Test 1",
																	url: URL(string: "Test 1"),
																	urlToImage: URL(string: "Test 1")),
														 ArticleDTO(author: "Test 2",
																	content: "Test 2",
																	publishedAt: "Test 2",
																	source: SourceDTO(category: "Test 2",
																					  country: "Test 2",
																					  id: "Test 2",
																					  language: "Test 2",
																					  name: "Test 2",
																					  story: "Test 2",
																					  url: URL(string: "Test 2")),
																	story: "Test 2",
																	title: "Test 2",
																	url: URL(string: "Test 2"),
																	urlToImage: URL(string: "Test 2"))],
											  status: "Test",
											  totalResults: 2)
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(sut.topHeadlinesQueriesSubject.value?.articles?.count, 2)
	}

	func testSaveSources() {
		// Given
		let sourcesDto = SourcesDTO(sources: [SourceDTO(category: "Test 3",
														country: "Test 3",
														id: "Test 3",
														language: "Test 3",
														name: "Test 3",
														story: "Test 3",
														url: URL(string: "Test 3")),
											  SourceDTO(category: "Test 4",
														country: "Test 4",
														id: "Test 4",
														language: "Test 4",
														name: "Test 4",
														story: "Test 4",
														url: URL(string: "Test 4"))],
									status: "Test")
		// When
		sut.saveSources(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(sut.topHeadlinesSourcesQueriesSubject.value?.sources?.count, 4)
	}
}
