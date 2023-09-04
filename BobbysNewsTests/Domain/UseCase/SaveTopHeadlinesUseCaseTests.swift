//
//  SaveTopHeadlinesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class SaveTopHeadlinesUseCaseTests: XCTestCase {

	private var sut: SaveTopHeadlinesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	override func setUpWithError() throws {
		topHeadlinesDataControllerMock = TopHeadlinesDataControllerMock()
		topHeadlinesQueriesRepositoryMock = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: topHeadlinesDataControllerMock)
		sut = SaveTopHeadlinesUseCase(topHeadlinesQueriesRepository: topHeadlinesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		topHeadlinesDataControllerMock = nil
		topHeadlinesQueriesRepositoryMock = nil
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
		XCTAssertEqual(topHeadlinesDataControllerMock.topHeadlinesQueriesSubject.value?.articles?.count, 4)
	}
}
