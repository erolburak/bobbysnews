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
		let contentViewModel = ContentViewModel(deleteSourcesUseCase: DeleteSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
												fetchRequestSourcesUseCase: FetchRequestSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
												fetchSourcesUseCase: FetchSourcesUseCase(sourcesRepository: SourcesRepository()),
												readSourcesUseCase: ReadSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
												saveSourcesUseCase: SaveSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
												deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
												fetchRequestTopHeadlinesUseCase: FetchRequestTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
												fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: TopHeadlinesRepository()),
												readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
												saveTopHeadlinesUseCase: SaveTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()))
		// Then
		XCTAssertNotNil(contentViewModel)
	}

	func testOnAppear() async {
		// Given
		sut.selectedCountry = nil
		sut.stateSources = .isInitialLoading
		sut.stateTopHeadlines = .isInitialLoading
		// When
		sut.onAppear(country: "")
		// Then
		await fulfillment(of: [], timeout: 1)
		XCTAssertNil(sut.selectedCountry)
		XCTAssertEqual(sut.stateSources, .isInitialLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isInitialLoading)
	}

	func testFetchSources() async {
		// Given
		sut.selectedCountry = nil
		sut.stateSources = .isInitialLoading
		sut.stateTopHeadlines = .isInitialLoading
		// When
		await sut.fetchSources()
		// Then
		XCTAssertNil(sut.selectedCountry)
		XCTAssertEqual(sut.stateSources, .isInitialLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isInitialLoading)
	}

	func testFetchTopHeadlines() async {
		// Given
		sut.selectedCountry = nil
		sut.stateSources = .isInitialLoading
		sut.stateTopHeadlines = .isInitialLoading
		// When
		await sut.fetchTopHeadlines()
		// Then
		XCTAssertNil(sut.selectedCountry)
		XCTAssertEqual(sut.stateSources, .isInitialLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isInitialLoading)
	}

	func testReset() {
		// Given
		sut.selectedCountry = "Test"
		sut.stateSources = .loaded
		sut.stateTopHeadlines = .loaded
		// When
		sut.reset()
		// Then
		XCTAssertNil(sut.selectedCountry)
		XCTAssertEqual(sut.stateSources, .load)
		XCTAssertEqual(sut.stateTopHeadlines, .emptyRead)
	}
}
