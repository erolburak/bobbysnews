//
//  ContentViewModelTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 31.08.23.
//

@testable import BobbysNews
import XCTest

class ContentViewModelTests: XCTestCase {

	// MARK: - Private Properties

	private var mock: ContentViewModelUseCaseMock!
	private var sut: ContentViewModel!

	// MARK: - Actions

	override func setUpWithError() throws {
		mock = ContentViewModelUseCaseMock()
		sut = ContentViewModel(deleteSourcesUseCase: mock,
							   fetchSourcesUseCase: mock,
							   readSourcesUseCase: mock,
							   deleteTopHeadlinesUseCase: mock,
							   fetchTopHeadlinesUseCase: mock,
							   readTopHeadlinesUseCase: mock)
	}

	override func tearDownWithError() throws {
		mock = nil
		sut = nil
	}

	// MARK: - Actions

	func testContentViewModel() {
		// Given
		let contentViewModel: ContentViewModel?
		// When
		contentViewModel = ContentViewModel(deleteSourcesUseCase: mock,
											fetchSourcesUseCase: mock,
											readSourcesUseCase: mock,
											deleteTopHeadlinesUseCase: mock,
											fetchTopHeadlinesUseCase: mock,
											readTopHeadlinesUseCase: mock)
		// Then
		XCTAssertNotNil(contentViewModel)
	}

	func testOnAppear() async throws {
		// Given
		sut.selectedCountry = ""
		// When
		sut.onAppear(selectedCountry: sut.selectedCountry)
		try await Task.sleep(for: .seconds(2))
		// Then
		XCTAssertEqual(sut.articles?.count, 5)
		XCTAssertEqual(sut.stateSources, .loaded)
		XCTAssertEqual(sut.stateTopHeadlines, .loaded)
	}

	func testFetchSources() async {
		// Given
		sut.articles = nil
		sut.countries = nil
		sut.selectedCountry = ""
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// When
		await sut.fetchSources()
		// Then
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .isLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isLoading)
	}

	func testFetchTopHeadlines() async {
		// Given
		sut.articles = nil
		sut.countries = nil
		sut.selectedCountry = ""
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// When
		await sut.fetchTopHeadlines(state: .isLoading)
		// Then
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .isLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isLoading)
	}

	func testReset() {
		// Given
		sut.apiKeyVersion = 2
		sut.articles = []
		sut.countries = []
		sut.stateSources = .loaded
		sut.stateTopHeadlines = .loaded
		// When
		sut.reset()
		// Then
		XCTAssertEqual(sut.apiKeyVersion, 1)
		XCTAssertNil(sut.articles)
		XCTAssertNil(sut.countries)
		XCTAssertEqual(sut.stateSources, .emptyRead)
		XCTAssertEqual(sut.stateTopHeadlines, .emptyRead)
	}
}
