//
//  RepositoryFactoryTests.swift
//	BobbysNewsData
//
//  Created by Burak Erol on 24.01.24.
//

@testable import BobbysNewsData
import XCTest

class RepositoryFactoryTests: XCTestCase {
	
	// MARK: - Private Properties
	
	private var sut: RepositoryFactory!
	
	// MARK: - Actions
	
	override func setUpWithError() throws {
		sut = RepositoryFactory()
	}
	
	override func tearDownWithError() throws {
		sut = nil
	}

	func testSourcesRepositoryIsNotNil() {
		// Given
		let sourcesRepository: PSourcesRepository?
		// When
		sourcesRepository = sut.sourcesRepository
		// Then
		XCTAssertNotNil(sourcesRepository)
	}

	func testTopHeadlinesRepositoryIsNotNil() {
		// Given
		let topHeadlinesRepository: PTopHeadlinesRepository?
		// When
		topHeadlinesRepository = sut.topHeadlinesRepository
		// Then
		XCTAssertNotNil(topHeadlinesRepository)
	}
}
