//
//  DeleteTopHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import XCTest

class DeleteTopHeadlinesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: DeleteTopHeadlinesUseCase!
	private var topHeadlinesPersistenceControllerMock: TopHeadlinesPersistenceControllerMock!
	private var topHeadlinesRepositoryMock: TopHeadlinesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		topHeadlinesPersistenceControllerMock = TopHeadlinesPersistenceControllerMock()
		topHeadlinesRepositoryMock = TopHeadlinesRepositoryMock(topHeadlinesPersistenceController: topHeadlinesPersistenceControllerMock)
		sut = DeleteTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock)
	}

	override func tearDownWithError() throws {
		sut = nil
		topHeadlinesPersistenceControllerMock = nil
		topHeadlinesRepositoryMock = nil
	}

	func testDelete() throws {
		// Given
		topHeadlinesPersistenceControllerMock.queriesSubject.value = EntityMock.topHeadlinesDB
		// When
		try sut
			.delete(country: nil)
		// Then
		XCTAssertNil(topHeadlinesPersistenceControllerMock.queriesSubject.value)
	}
}
