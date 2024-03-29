//
//  ReadSourcesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
import Combine
import XCTest

class ReadSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellables: Set<AnyCancellable>!
	private var sut: ReadSourcesUseCase!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellables = Set<AnyCancellable>()
		sut = ReadSourcesUseCase(sourcesRepository: SourcesRepositoryMock())
	}

	override func tearDownWithError() throws {
		cancellables.removeAll()
		sut = nil
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
			.store(in: &cancellables)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(sources)
	}
}
