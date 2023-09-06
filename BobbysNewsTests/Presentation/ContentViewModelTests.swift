//
//  ContentViewModelTests.swift
//  ContentViewModelTests
//
//  Created by Burak Erol on 31.08.23.
//

@testable import BobbysNews
import XCTest

class ContentViewModelTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: ContentViewModel!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		sut = ViewModelDI.shared.contentViewModel()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	// MARK: - Actions

	func testContentViewModelIsNotNil() async {
		// When
		let contentViewModel = ContentViewModel(deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
												fetchRequestTopHeadlinesUseCase: FetchRequestTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
							  fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: TopHeadlinesRepository()),
							  readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
							  saveTopHeadlinesUseCase: SaveTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
							  fetchRequestTopHeadlinesSourcesUseCase: FetchRequestTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
							  fetchTopHeadlinesSourcesUseCase: FetchTopHeadlinesSourcesUseCase(topHeadlinesRepository: TopHeadlinesRepository()),
							  readTopHeadlinesSourcesUseCase: ReadTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
							  saveTopHeadlinesSourcesUseCase: SaveTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()))
		// Then
		XCTAssertNotNil(contentViewModel)
	}

	func testOnAppear() async {
		// Given
		sut.selectedCountry = ""
		sut.stateSources = .isInitialLoading
		sut.stateTopHeadlines = .isInitialLoading
		// When
		sut.onAppear(country: "")
		// Then
		await fulfillment(of: [], timeout: 1)
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .isInitialLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isInitialLoading)
	}

	func testDelete() {
		// Given
		sut.selectedCountry = "Test"
		sut.stateSources = .loaded
		sut.stateTopHeadlines = .loaded
		// When
		sut.delete()
		// Then
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .emptyRead)
		XCTAssertEqual(sut.stateTopHeadlines, .emptyRead)
	}

	func testFetchTopHeadlines() async {
		// Given
		sut.selectedCountry = ""
		sut.stateSources = .isInitialLoading
		sut.stateTopHeadlines = .isInitialLoading
		// When
		await sut.fetchTopHeadlines()
		// Then
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .isInitialLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isInitialLoading)
	}

	func testFetchTopHeadlinesSources() async {
		// Given
		sut.selectedCountry = ""
		sut.stateSources = .isInitialLoading
		sut.stateTopHeadlines = .isInitialLoading
		// When
		await sut.fetchTopHeadlinesSources()
		// Then
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .isInitialLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isInitialLoading)
	}

	func testShowAlerts() {
		for error in AppConfiguration.Errors.allCases {
			testShowAlertIsNotNil(error: error)
		}
	}

	private func testShowAlertIsNotNil(error: AppConfiguration.Errors) {
		// Given
		sut.showAlert = false
		// When
		sut.showAlert(error: error)
		// Then
		XCTAssertTrue(sut.showAlert)
		XCTAssertEqual(sut.alertError, error)
		XCTAssertNotNil(sut.alertError?.errorDescription)
		XCTAssertNotNil(sut.alertError?.recoverySuggestion)
	}
}
