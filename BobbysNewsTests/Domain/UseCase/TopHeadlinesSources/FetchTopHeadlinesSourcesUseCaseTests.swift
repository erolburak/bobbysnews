//
//  FetchTopHeadlinesSourcesUseCaseTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 05.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class FetchTopHeadlinesSourcesUseCaseTests: XCTestCase {

	private var cancellable: Set<AnyCancellable>!
	private var mock: TopHeadlinesRepositoryMock!
	private var sut: FetchTopHeadlinesSourcesUseCase!

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		mock = TopHeadlinesRepositoryMock()
		sut = FetchTopHeadlinesSourcesUseCase(topHeadlinesRepository: mock)
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		mock = nil
		sut = nil
	}

	func testFetchSources() async {
		// Given
		var sourcesDto: SourcesDTO?
		// When
		let expectation = expectation(description: "FetchSources")
		sut.fetchSources()
			.sink(receiveCompletion: { _ in },
				  receiveValue: {
				sourcesDto = $0
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(sourcesDto)
	}
}
