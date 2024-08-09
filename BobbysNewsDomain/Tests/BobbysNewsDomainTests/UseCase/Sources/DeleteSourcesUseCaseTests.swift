//
//  DeleteSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
import XCTest

class DeleteSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var entity: EntityMock!
	private var mock: SourcesRepositoryMock!
	private var sut: DeleteSourcesUseCase!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
		mock = SourcesRepositoryMock()
		sut = DeleteSourcesUseCase(sourcesRepository: mock)
	}

	override func tearDownWithError() throws {
		entity = nil
		mock = nil
		sut = nil
	}

	func testDelete() throws {
		// Given
		mock.sourcesPersistenceController.queriesSubject.value = entity.sourcesDB
		// When
		try sut
			.delete()
		// Then
		XCTAssertNil(mock.sourcesPersistenceController.queriesSubject.value)
	}
}
