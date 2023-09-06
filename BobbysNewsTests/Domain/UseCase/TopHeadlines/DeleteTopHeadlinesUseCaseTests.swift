//
//  DeleteTopHeadlinesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class DeleteTopHeadlinesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: DeleteTopHeadlinesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		topHeadlinesDataControllerMock = TopHeadlinesDataControllerMock()
		topHeadlinesQueriesRepositoryMock = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: topHeadlinesDataControllerMock)
		sut = DeleteTopHeadlinesUseCase(topHeadlinesQueriesRepository: topHeadlinesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		topHeadlinesDataControllerMock = nil
		topHeadlinesDataControllerMock = nil
	}

	// MARK: - Actions

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
		XCTAssertNil(topHeadlinesDataControllerMock.topHeadlinesQueriesSubject.value)
	}
}
