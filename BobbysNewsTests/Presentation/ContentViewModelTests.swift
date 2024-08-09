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

	private var entity: EntityMock!
	private var sut: ContentViewModel!
	private var sourcesRepositoryMock: SourcesRepositoryMock!
	private var topHeadlinesRepositoryMock: TopHeadlinesRepositoryMock!

	// MARK: - Actions

	override func setUpWithError() throws {
		entity = EntityMock()
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
		entity = nil
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

	@MainActor
	func testFetchSources() async throws {
		// Given
		sut.countries = [entity.sources.sources?.first?.country ?? "Test"]
		sut.selectedCountry = "Test"
		// When
		sut.fetchSources()
		try await Task.sleep(for: .seconds(2))
		// Then
		XCTAssertEqual(sut.countries?.count, 1)
	}

	@MainActor
	func testFetchTopHeadlines() async throws {
		// Given
		sut.articles = [entity.article]
		sut.selectedCountry = "Test"
		// When
		sut.fetchTopHeadlines(state: .isLoading)
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
		sut.articles = [entity.article]
		sut.countries = [entity.sources.sources?.first?.country ?? "Test"]
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

	func testShowSettingsTip() throws {
		// Given
		ContentViewModel.SettingsTip.show = false
		// When
		try sut.showSettingsTip()
		// Then
		XCTAssertTrue(ContentViewModel.SettingsTip.show)
	}
}
