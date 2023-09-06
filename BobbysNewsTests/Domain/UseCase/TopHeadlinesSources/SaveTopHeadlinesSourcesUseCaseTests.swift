//
//  SaveTopHeadlinesSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class SaveTopHeadlinesSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: SaveTopHeadlinesSourcesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	// MARK: - Life Cycle

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

	// MARK: - Actions

	func testSaveSources() {
		// Given
		let sourcesDto = DTOMock.sourcesDto
		// When
		sut.saveSources(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(topHeadlinesDataControllerMock.topHeadlinesSourcesQueriesSubject.value?.sources?.count, 4)
	}
}
