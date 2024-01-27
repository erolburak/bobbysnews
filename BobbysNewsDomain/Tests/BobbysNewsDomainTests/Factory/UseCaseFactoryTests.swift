//
//  UseCaseFactoryTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 25.01.24.
//

@testable import BobbysNewsDomain
import XCTest

class RepositoryFactoryTests: XCTestCase {
	
	// MARK: - Private Properties
	
	private var sut: UseCaseFactory!
	
	// MARK: - Actions
	
	override func setUpWithError() throws {
		sut = UseCaseFactory()
	}
	
	override func tearDownWithError() throws {
		sut = nil
	}

	func testDeleteSourcesUseCaseIsNotNil() {
		// Given
		let deleteSourcesUseCase: PDeleteSourcesUseCase?
		// When
		deleteSourcesUseCase = sut.deleteSourcesUseCase
		// Then
		XCTAssertNotNil(deleteSourcesUseCase)
	}

	func testFetchSourcesUseCaseIsNotNil() {
		// Given
		let fetchSourcesUseCase: PFetchSourcesUseCase?
		// When
		fetchSourcesUseCase = sut.fetchSourcesUseCase
		// Then
		XCTAssertNotNil(fetchSourcesUseCase)
	}

	func testReadSourcesUseCaseIsNotNil() {
		// Given
		let readSourcesUseCase: PReadSourcesUseCase?
		// When
		readSourcesUseCase = sut.readSourcesUseCase
		// Then
		XCTAssertNotNil(readSourcesUseCase)
	}

	func testDeleteTopHeadlinesUseCaseIsNotNil() {
		// Given
		let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase?
		// When
		deleteTopHeadlinesUseCase = sut.deleteTopHeadlinesUseCase
		// Then
		XCTAssertNotNil(deleteTopHeadlinesUseCase)
	}

	func testFetchTopHeadlinesUseCaseIsNotNil() {
		// Given
		let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase?
		// When
		fetchTopHeadlinesUseCase = sut.fetchTopHeadlinesUseCase
		// Then
		XCTAssertNotNil(fetchTopHeadlinesUseCase)
	}

	func testReadTopHeadlinesUseCaseIsNotNil() {
		// Given
		let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase?
		// When
		readTopHeadlinesUseCase = sut.readTopHeadlinesUseCase
		// Then
		XCTAssertNotNil(readTopHeadlinesUseCase)
	}
}
