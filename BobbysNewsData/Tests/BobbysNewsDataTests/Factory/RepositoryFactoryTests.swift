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

	@Test("Check initializing SourcesRepository!")
	func testSourcesRepositoryIsNotNil() {
		// Given
		let sourcesRepository: PSourcesRepository?
		// When
		sourcesRepository = sut.sourcesRepository
		// Then
		#expect(sourcesRepository != nil,
				"Initializing SourcesRepository failed!")
	}

	@Test("Check initializing TopHeadlinesRepository!")
	func testTopHeadlinesRepositoryIsNotNil() {
		// Given
		let topHeadlinesRepository: PTopHeadlinesRepository?
		// When
		topHeadlinesRepository = sut.topHeadlinesRepository
		// Then
		#expect(topHeadlinesRepository != nil,
				"Initializing TopHeadlinesRepository failed!")
	}
}
