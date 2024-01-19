//
//  SaveTopHeadlinesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class SaveTopHeadlinesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: SaveTopHeadlinesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	// MARK: - Actions

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

	func testSaveWithExistingTopHeadlines() {
		// Given
		let topHeadlinesDto = DTOMock.topHeadlinesDto1
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(topHeadlinesDataControllerMock.queriesSubject.value?.articles?.count, 2)
	}

	func testSaveWithNewTopHeadlines() {
		// Given
		let topHeadlinesDto = DTOMock.topHeadlinesDto2
		// When
		sut.save(country: "Test",
				 topHeadlinesDto: topHeadlinesDto)
		// Then
		XCTAssertEqual(topHeadlinesDataControllerMock.queriesSubject.value?.articles?.count, 4)
	}
}
