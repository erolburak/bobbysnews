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

	// MARK: - Actions

	override func setUpWithError() throws {
		sut = ViewModelDI.shared.contentViewModel()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testContentViewModelIsNotNil() {
		// When
		let contentViewModel = ContentViewModel(deleteSourcesUseCase: DeleteSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
												fetchRequestSourcesUseCase: FetchRequestSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
												fetchSourcesUseCase: FetchSourcesUseCase(sourcesRepository: SourcesRepository()),
												readSourcesUseCase: ReadSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
												deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
												fetchRequestTopHeadlinesUseCase: FetchRequestTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
												fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: TopHeadlinesRepository()),
												readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()))
		// Then
		XCTAssertNotNil(contentViewModel)
	}

	func testOnAppear() async throws {
		// Given
		let country = "Test"
		// When
		sut.articles = nil
		sut.countries = nil
		sut.selectedCountry = country
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// Then
		try await Task.sleep(for: .seconds(5))
		XCTAssertEqual(sut.selectedCountry, country)
		if sut.alertError == .limitedRequests {
			XCTAssertEqual(sut.stateSources, .loaded)
			XCTAssertEqual(sut.stateTopHeadlines, .loaded)
		} else {
			XCTAssertEqual(sut.stateSources, .isLoading)
			XCTAssertEqual(sut.stateTopHeadlines, .isLoading)
		}
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
