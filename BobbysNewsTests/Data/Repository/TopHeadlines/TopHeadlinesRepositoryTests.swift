//
//  TopHeadlinesRepositoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine
import XCTest

class TopHeadlinesRepositoryTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var sut: TopHeadlinesRepositoryMock!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sut = TopHeadlinesRepositoryMock()
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
	}

	// MARK: - Actions

	func testFetchIsNotNil() async {
		// Given
		var topHeadlinesDto: TopHeadlinesDTO?
		// When
		let expectation = expectation(description: "Fetch")
		sut.fetch(apiKey: "Test",
				  country: "Test")
			.sink(receiveCompletion: { _ in },
				  receiveValue: {
				topHeadlinesDto = $0
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(topHeadlinesDto)
	}

	func testFetchIsNil() async {
		// Given
		var topHeadlinesDto: TopHeadlinesDTO?
		// When
		let expectation = expectation(description: "Fetch")
		sut.fetch(apiKey: "",
				  country: "")
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished:
					break
				case .failure:
					expectation.fulfill()
				}
			}, receiveValue: {
				topHeadlinesDto = $0
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNil(topHeadlinesDto)
	}
}
