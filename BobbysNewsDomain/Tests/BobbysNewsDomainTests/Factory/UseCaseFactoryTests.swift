//
//  UseCaseFactoryTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 25.01.24.
//

@testable import BobbysNewsDomain
import Testing

struct RepositoryFactoryTests {
	
	// MARK: - Private Properties
	
	private let sut = UseCaseFactory()
	
	// MARK: - Actions

	@Test("Check initializing DeleteSourcesUseCase!")
	func testDeleteSourcesUseCaseIsNotNil() {
		// Given
		let deleteSourcesUseCase: PDeleteSourcesUseCase?
		// When
		deleteSourcesUseCase = sut.deleteSourcesUseCase
		// Then
		#expect(deleteSourcesUseCase != nil,
				"Initializing DeleteSourcesUseCase failed!")
	}

	@Test("Check initializing FetchSourcesUseCase!")
	func testFetchSourcesUseCaseIsNotNil() {
		// Given
		let fetchSourcesUseCase: PFetchSourcesUseCase?
		// When
		fetchSourcesUseCase = sut.fetchSourcesUseCase
		// Then
		#expect(fetchSourcesUseCase != nil,
				"Initializing FetchSourcesUseCase failed!")
	}

	@Test("Check initializing ReadSourcesUseCase!")
	func testReadSourcesUseCaseIsNotNil() {
		// Given
		let readSourcesUseCase: PReadSourcesUseCase?
		// When
		readSourcesUseCase = sut.readSourcesUseCase
		// Then
		#expect(readSourcesUseCase != nil,
				"Initializing ReadSourcesUseCase failed!")
	}

	@Test("Check initializing DeleteTopHeadlinesUseCase!")
	func testDeleteTopHeadlinesUseCaseIsNotNil() {
		// Given
		let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase?
		// When
		deleteTopHeadlinesUseCase = sut.deleteTopHeadlinesUseCase
		// Then
		#expect(deleteTopHeadlinesUseCase != nil,
				"Initializing DeleteTopHeadlinesUseCase failed!")
	}

	@Test("Check initializing FetchTopHeadlinesUseCase!")
	func testFetchTopHeadlinesUseCaseIsNotNil() {
		// Given
		let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase?
		// When
		fetchTopHeadlinesUseCase = sut.fetchTopHeadlinesUseCase
		// Then
		#expect(fetchTopHeadlinesUseCase != nil,
				"Initializing FetchTopHeadlinesUseCase failed!")
	}

	@Test("Check initializing ReadTopHeadlinesUseCase!")
	func testReadTopHeadlinesUseCaseIsNotNil() {
		// Given
		let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase?
		// When
		readTopHeadlinesUseCase = sut.readTopHeadlinesUseCase
		// Then
		#expect(readTopHeadlinesUseCase != nil,
				"Initializing ReadTopHeadlinesUseCase failed!")
	}
}
