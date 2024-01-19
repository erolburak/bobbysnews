//
//  FetchSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class FetchSourcesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var mock: SourcesRepositoryMock!
	private var sut: FetchSourcesUseCase!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		mock = SourcesRepositoryMock()
		sut = FetchSourcesUseCase(sourcesRepository: mock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		mock = nil
		sut = nil
	}

	func testFetch() async {
		// Given
		var sourcesDto: SourcesDTO?
		// When
		let expectation = expectation(description: "Fetch")
		sut.fetch(apiKey: "Test")
			.sink(receiveCompletion: { _ in },
				  receiveValue: { newSourcesDto in
				sourcesDto = newSourcesDto
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(sourcesDto)
	}
}
