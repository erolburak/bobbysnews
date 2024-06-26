//
//  ContentViewModelTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 31.08.23.
//

@testable import BobbysNews
import BobbysNewsData
import BobbysNewsDomain
import TipKit
import XCTest

class ContentViewModelTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: ContentViewModel!
	private var sourcesRepositoryMock: SourcesRepositoryMock!
	private var topHeadlinesRepositoryMock: TopHeadlinesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		sourcesRepositoryMock = SourcesRepositoryMock()
		topHeadlinesRepositoryMock = TopHeadlinesRepositoryMock()
		sut = ContentViewModel(deleteSourcesUseCase: DeleteSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
							   fetchSourcesUseCase: FetchSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
							   readSourcesUseCase: ReadSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
							   deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
							   fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
							   readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock))
	}

	override func tearDownWithError() throws {
		sut = nil
		sourcesRepositoryMock = nil
		topHeadlinesRepositoryMock = nil
	}

	// MARK: - Actions

	func testContentViewModel() {
		// Given
		let contentViewModel: ContentViewModel?
		// When
		contentViewModel = ContentViewModel(deleteSourcesUseCase: DeleteSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
											fetchSourcesUseCase: FetchSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
											readSourcesUseCase: ReadSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
											deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
											fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
											readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock))
		// Then
		XCTAssertNotNil(contentViewModel)
	}

	func testOnAppear() async throws {
		// Given
		sut.selectedCountry = "Test"
		// When
		sut.onAppear(selectedCountry: sut.selectedCountry)
		try await Task.sleep(for: .seconds(2))
		// Then
		XCTAssertEqual(sut.articles?.count, 1)
		XCTAssertEqual(sut.countries?.count, 1)
		XCTAssertEqual(sut.stateSources, .loaded)
		XCTAssertEqual(sut.stateTopHeadlines, .loaded)
	}

	func testFetchSources() async throws {
		// Given
		sut.countries = [EntityMock.sources.sources?.first?.country ?? "Test"]
		sut.selectedCountry = "Test"
		// When
		await sut.fetchSources()
		try await Task.sleep(for: .seconds(2))
		// Then
		XCTAssertEqual(sut.countries?.count, 1)
	}

	func testFetchTopHeadlines() async throws {
		// Given
		sut.articles = [EntityMock.article]
		sut.selectedCountry = "Test"
		// When
		await sut.fetchTopHeadlines(state: .isLoading)
		try await Task.sleep(for: .seconds(2))
		// Then
		XCTAssertEqual(sut.articles?.count, 1)
	}

	func testInvalidateSettingsTip() async {
		// Given
		var tipsStatus: Tips.Status?
		// When
		let expectation = expectation(description: "Invalidate")
		sut.invalidateSettingsTip()
		for await status in sut.settingsTip.statusUpdates {
			if status == .invalidated(.actionPerformed) {
				tipsStatus = status
				expectation.fulfill()
			}
		}
		// Then
		await fulfillment(of: [expectation], timeout: 1)
		XCTAssertNotNil(tipsStatus)
	}

	func testReset() {
		// Given
		sut.apiKeyVersion = 2
		sut.articles = [EntityMock.article]
		sut.countries = [EntityMock.sources.sources?.first?.country ?? "Test"]
		sut.selectedCountry = "Test"
		sut.stateSources = .loaded
		sut.stateTopHeadlines = .loaded
		// When
		sut.reset()
		// Then
		XCTAssertEqual(sut.apiKeyVersion, 1)
		XCTAssertNil(sut.articles)
		XCTAssertNil(sut.countries)
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .emptyRead)
		XCTAssertEqual(sut.stateTopHeadlines, .emptyRead)
	}

	func testShowSettingsTip() async throws {
		// Given
		ContentViewModel.SettingsTip.show = false
		// When
		try await sut.showSettingsTip()
		// Then
		XCTAssertTrue(ContentViewModel.SettingsTip.show)
	}
}
