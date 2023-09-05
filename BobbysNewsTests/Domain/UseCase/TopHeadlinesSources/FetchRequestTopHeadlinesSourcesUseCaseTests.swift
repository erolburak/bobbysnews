//
//  FetchRequestTopHeadlinesSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class FetchRequestTopHeadlinesSourcesUseCaseTests: XCTestCase {

	private var sut: FetchRequestTopHeadlinesSourcesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	override func setUpWithError() throws {
		topHeadlinesDataControllerMock = TopHeadlinesDataControllerMock()
		topHeadlinesQueriesRepositoryMock = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: topHeadlinesDataControllerMock)
		sut = FetchRequestTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: topHeadlinesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		topHeadlinesDataControllerMock = nil
		topHeadlinesQueriesRepositoryMock = nil
	}

	func testFetchSourcesRequest() {
		// When
		sut.fetchSourcesRequest()
		// Then
		XCTAssertEqual(topHeadlinesDataControllerMock.topHeadlinesSourcesQueriesSubject.value?.sources?.count, 2)
	}
}
