//
//  SaveTopHeadlinesSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class SaveTopHeadlinesSourcesUseCaseTests: XCTestCase {

	private var sut: SaveTopHeadlinesSourcesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	override func setUpWithError() throws {
		topHeadlinesDataControllerMock = TopHeadlinesDataControllerMock()
		topHeadlinesQueriesRepositoryMock = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: topHeadlinesDataControllerMock)
		sut = SaveTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: topHeadlinesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		topHeadlinesDataControllerMock = nil
		topHeadlinesQueriesRepositoryMock = nil
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
		XCTAssertEqual(topHeadlinesDataControllerMock.topHeadlinesSourcesQueriesSubject.value?.sources?.count, 4)
	}
}
