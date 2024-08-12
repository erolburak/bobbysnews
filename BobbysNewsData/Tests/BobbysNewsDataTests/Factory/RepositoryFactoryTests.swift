//
//  RepositoryFactoryTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 24.01.24.
//

@testable import BobbysNewsData
import Testing

struct RepositoryFactoryTests {

	// MARK: - Private Properties

	private let sut = RepositoryFactory()

	// MARK: - Actions

	@Test("Check SourcesRepository initializing!")
	func testSourcesRepository() {
		// Given
		let sourcesRepository: PSourcesRepository?
		// When
		sourcesRepository = sut.sourcesRepository
		// Then
		#expect(sourcesRepository != nil,
				"SourcesRepository initializing failed!")
	}

	@Test("Check TopHeadlinesRepository initializing!")
	func testTopHeadlinesRepository() {
		// Given
		let topHeadlinesRepository: PTopHeadlinesRepository?
		// When
		topHeadlinesRepository = sut.topHeadlinesRepository
		// Then
		#expect(topHeadlinesRepository != nil,
				"TopHeadlinesRepository initializing failed!")
	}
}
