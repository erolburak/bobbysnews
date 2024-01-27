//
//  DeleteSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class DeleteSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: DeleteSourcesUseCase!
	private var sourcesPersistenceControllerMock: SourcesPersistenceControllerMock!
	private var sourcesRepositoryMock: SourcesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		sourcesPersistenceControllerMock = SourcesPersistenceControllerMock()
		sourcesRepositoryMock = SourcesRepositoryMock(sourcesPersistenceController: sourcesPersistenceControllerMock)
		sut = DeleteSourcesUseCase(sourcesRepository: sourcesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		sourcesPersistenceControllerMock = nil
		sourcesRepositoryMock = nil
	}

	func testDelete() throws {
		// Given
		sourcesPersistenceControllerMock.queriesSubject.value = EntityMock.sourcesDB
		// When
		try sut
			.delete()
		// Then
		XCTAssertNil(sourcesPersistenceControllerMock.queriesSubject.value)
	}
}
