//
//  ReadTopHeadlinesSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class ReadTopHeadlinesSourcesUseCaseTests: XCTestCase {

	private var cancellable: Set<AnyCancellable>!
	private var sut: ReadTopHeadlinesSourcesUseCase!
	private var topHeadlinesDataControllerMock: TopHeadlinesDataControllerMock!
	private var topHeadlinesQueriesRepositoryMock: TopHeadlinesQueriesRepositoryMock!

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		topHeadlinesDataControllerMock = TopHeadlinesDataControllerMock()
		topHeadlinesQueriesRepositoryMock = TopHeadlinesQueriesRepositoryMock(topHeadlinesDataController: topHeadlinesDataControllerMock)
		sut = ReadTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: topHeadlinesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
		topHeadlinesDataControllerMock = nil
		topHeadlinesQueriesRepositoryMock = nil
	}

	func testReadSources() async {
		// Given
		var sources: Sources?
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
}
