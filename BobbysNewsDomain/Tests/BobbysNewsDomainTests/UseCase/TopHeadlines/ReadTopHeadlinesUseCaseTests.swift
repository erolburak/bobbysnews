//
//  ReaApipHeadlinesUseCaseTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsDomain
import BobbysNewsData
import Combine
import XCTest

class ReaApipHeadlinesUseCaseTests: XCTestCase {

	// MARK: - Private Properties

	private var cancellable: Set<AnyCancellable>!
	private var sut: ReadTopHeadlinesUseCase!

	// MARK: - Actions

	override func setUpWithError() throws {
		cancellable = Set<AnyCancellable>()
		sut = ReadTopHeadlinesUseCase(topHeadlinesRepository: TopHeadlinesRepositoryMock())
	}

	override func tearDownWithError() throws {
		cancellable.removeAll()
		sut = nil
	}

	func testRead() async {
		// Given
		var topHeadlines: TopHeadlines?
		// When
		let expectation = expectation(description: "Read")
		sut
			.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { newTopHeadlines in
				topHeadlines = newTopHeadlines
				expectation.fulfill()
			})
			.store(in: &cancellable)
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(topHeadlines)
	}
}
