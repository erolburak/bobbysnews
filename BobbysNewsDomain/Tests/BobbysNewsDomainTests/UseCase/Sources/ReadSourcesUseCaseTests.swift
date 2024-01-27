//
//  ReadSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import Combine
import XCTest

class ReadSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var sut: ReadSourcesUseCase!
	private var sourcesPersistenceControllerMock: SourcesPersistenceControllerMock!
	private var sourcesRepositoryMock: SourcesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sourcesPersistenceControllerMock = SourcesPersistenceControllerMock()
		sourcesRepositoryMock = SourcesRepositoryMock(sourcesPersistenceController: sourcesPersistenceControllerMock)
		sut = ReadSourcesUseCase(sourcesRepository: sourcesRepositoryMock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
		sourcesPersistenceControllerMock = nil
		sourcesRepositoryMock = nil
	}

	func testRead() async {
		// Given
		var sources: Sources?
		// When
		let expectation = expectation(description: "Read")
		sut
			.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: {
				sources = $0
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(sources)
	}
}
