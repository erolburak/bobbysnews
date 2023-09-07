//
//  FetchRequestSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class FetchRequestSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: FetchRequestSourcesUseCase!
	private var sourcesDataControllerMock: SourcesDataControllerMock!
	private var sourcesQueriesRepositoryMock: SourcesQueriesRepositoryMock!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		sourcesDataControllerMock = SourcesDataControllerMock()
		sourcesQueriesRepositoryMock = SourcesQueriesRepositoryMock(sourcesDataController: sourcesDataControllerMock)
		sut = FetchRequestSourcesUseCase(sourcesQueriesRepository: sourcesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		sourcesDataControllerMock = nil
		sourcesQueriesRepositoryMock = nil
	}

	// MARK: - Actions

	func testFetchRequest() {
		// When
		sut.fetchRequest()
		// Then
		XCTAssertEqual(sourcesDataControllerMock.queriesSubject.value?.sources?.count, 2)
	}
}
