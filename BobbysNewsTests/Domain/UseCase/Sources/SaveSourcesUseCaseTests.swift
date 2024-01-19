//
//  SaveSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import XCTest

class SaveSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: SaveSourcesUseCase!
	private var sourcesDataControllerMock: SourcesDataControllerMock!
	private var sourcesQueriesRepositoryMock: SourcesQueriesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		sourcesDataControllerMock = SourcesDataControllerMock()
		sourcesQueriesRepositoryMock = SourcesQueriesRepositoryMock(sourcesDataController: sourcesDataControllerMock)
		sut = SaveSourcesUseCase(sourcesQueriesRepository: sourcesQueriesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		sourcesDataControllerMock = nil
		sourcesQueriesRepositoryMock = nil
	}

	func testSaveWithExistingSources() {
		// Given
		let sourcesDto = DTOMock.sourcesDto1
		// When
		sut.save(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(sourcesDataControllerMock.queriesSubject.value?.sources?.count, 2)
	}

	func testSaveWithNewSources() {
		// Given
		let sourcesDto = DTOMock.sourcesDto2
		// When
		sut.save(sourcesDto: sourcesDto)
		// Then
		XCTAssertEqual(sourcesDataControllerMock.queriesSubject.value?.sources?.count, 4)
	}
}
