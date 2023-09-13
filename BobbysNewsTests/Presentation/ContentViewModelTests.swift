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

	func testContentViewModelIsNotNil() {
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

	func testOnAppear() async throws {
		// Given
		sut.articles = nil
		sut.countries = nil
		sut.selectedCountry = nil
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// When
		sut.onAppear(country: "Test")
		// Then
		try await Task.sleep(for: .seconds(5))
		XCTAssertNotNil(sut.selectedCountry)
		if sut.alertError == .limitedRequests {
			XCTAssertEqual(sut.stateSources, .emptyFetch)
			XCTAssertEqual(sut.stateTopHeadlines, .emptyRead)
		} else {
			XCTAssertEqual(sut.stateSources, .loaded)
			XCTAssertEqual(sut.stateTopHeadlines, .emptyRead)
		}
	}

	func testFetchSources() async {
		// Given
		sut.articles = nil
		sut.countries = nil
		sut.selectedCountry = nil
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// When
		await sut.fetchSources(state: .isLoading)
		// Then
		XCTAssertNil(sut.selectedCountry)
		XCTAssertEqual(sut.stateSources, .isLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isLoading)
	}

	func testFetchTopHeadlines() async {
		// Given
		sut.articles = nil
		sut.countries = nil
		sut.selectedCountry = nil
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// When
		await sut.fetchTopHeadlines(state: .isLoading)
		// Then
		XCTAssertNil(sut.selectedCountry)
		XCTAssertEqual(sut.stateSources, .isLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isLoading)
	}

	func testReset() {
		// Given
		sut.apiKeyVersion = 2
		sut.articles = []
		sut.countries = []
		sut.selectedCountry = "Test"
		sut.stateSources = .loaded
		sut.stateTopHeadlines = .loaded
		// When
		sut.reset()
		// Then
		XCTAssertEqual(sut.apiKeyVersion, 1)
		XCTAssertNil(sut.articles)
		XCTAssertNil(sut.countries)
		XCTAssertNil(sut.selectedCountry)
		XCTAssertEqual(sut.stateSources, .emptyRead)
		XCTAssertEqual(sut.stateTopHeadlines, .emptyRead)
	}
}
