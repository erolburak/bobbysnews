//
//  FetchRequestTopHeadlinesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class FetchRequestTopHeadlinesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: FetchRequestTopHeadlinesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		topHeadlinesDataControllerMock = TopHeadlinesDataControllerMock()
		topHeadlinesQueriesRepositoryMock = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: topHeadlinesDataControllerMock)
		sut = FetchRequestTopHeadlinesUseCase(topHeadlinesQueriesRepository: topHeadlinesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		topHeadlinesDataControllerMock = nil
		topHeadlinesQueriesRepositoryMock = nil
	}

	func testFetchRequest() {
		// Given
		let country = "Test 1"
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(topHeadlinesDataControllerMock.queriesSubject.value?.articles?.count, 1)
	}

	func testFetchRequestIsEmpty() {
		// Given
		let country = ""
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(topHeadlinesDataControllerMock.queriesSubject.value?.articles?.count, 0)
	}
}
