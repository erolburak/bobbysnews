//
//  DeleteTopHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
import XCTest

class DeleteTopHeadlinesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var mock: TopHeadlinesRepositoryMock!
	private var sut: DeleteTopHeadlinesUseCase!

	// MARK: - Actions

	override func setUpWithError() throws {
		mock = TopHeadlinesRepositoryMock()
		sut = DeleteTopHeadlinesUseCase(topHeadlinesRepository: mock)
	}

	override func tearDownWithError() throws {
		mock = nil
		sut = nil
	}

	func testDelete() throws {
		// Given
		mock.topHeadlinesPersistenceController.queriesSubject.value = EntityMock.topHeadlinesDB
		// When
		try sut
			.delete()
		// Then
		XCTAssertNil(mock.topHeadlinesPersistenceController.queriesSubject.value)
	}
}
