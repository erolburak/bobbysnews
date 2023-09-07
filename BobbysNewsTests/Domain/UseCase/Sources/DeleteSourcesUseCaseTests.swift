//
//  DeleteSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews
import XCTest

class DeleteSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: DeleteSourcesUseCase!
	private var sourcesDataControllerMock: SourcesDataControllerMock!
	private var sourcesQueriesRepositoryMock: SourcesQueriesRepositoryMock!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		sourcesDataControllerMock = SourcesDataControllerMock()
		sourcesQueriesRepositoryMock = SourcesQueriesRepositoryMock(sourcesDataController: sourcesDataControllerMock)
		sut = DeleteSourcesUseCase(sourcesQueriesRepository: sourcesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		sourcesDataControllerMock = nil
		sourcesQueriesRepositoryMock = nil
	}

	// MARK: - Actions

	func testDelete() {
		XCTAssertNoThrow(try sut.delete())
		XCTAssertNil(sourcesDataControllerMock.queriesSubject.value)
	}
}
