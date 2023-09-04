//
//  FetchRequestTopHeadlinesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class FetchRequestTopHeadlinesUseCaseTests: XCTestCase {

	private var sut: FetchRequestTopHeadlinesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	override func setUpWithError() throws {
		topHeadlinesDataControllerMock = TopHeadlinesDataControllerMock()
		topHeadlinesQueriesRepositoryMock = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: topHeadlinesDataControllerMock)
		sut = FetchRequestTopHeadlinesUseCase(topHeadlinesQueriesRepository: topHeadlinesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		topHeadlinesDataControllerMock = nil
		topHeadlinesDataControllerMock = nil
	}

	func testFetchRequestWithCountryGermany() {
		// Given
		let country = Country.germany
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(topHeadlinesDataControllerMock.topHeadlinesQueriesSubject.value?.articles?.count, 2)
	}

	func testFetchRequestWithCountryNoneIsEmpty() {
		// Given
		let country = Country.none
		// When
		sut.fetchRequest(country: country)
		// Then
		XCTAssertEqual(topHeadlinesDataControllerMock.topHeadlinesQueriesSubject.value?.articles?.count, 0)
	}
}
