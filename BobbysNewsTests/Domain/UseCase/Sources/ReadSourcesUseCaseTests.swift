//
//  ReadSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class ReadSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var sut: ReadSourcesUseCase!
	private var sourcesDataControllerMock: SourcesDataControllerMock!
	private var sourcesQueriesRepositoryMock: SourcesQueriesRepositoryMock!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sourcesDataControllerMock = SourcesDataControllerMock()
		sourcesQueriesRepositoryMock = SourcesQueriesRepositoryMock(sourcesDataController: sourcesDataControllerMock)
		sut = ReadSourcesUseCase(sourcesQueriesRepository: sourcesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
		sourcesDataControllerMock = nil
		sourcesQueriesRepositoryMock = nil
	}

	// MARK: - Actions

	func testRead() async {
		// Given
		var sources: Sources?
		// When
		let expectation = expectation(description: "Read")
		sut.read()
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
