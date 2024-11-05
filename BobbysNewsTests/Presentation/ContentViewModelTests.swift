//
//  ContentViewModelTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 31.08.23.
//

import BobbysNewsData
import BobbysNewsDomain
import Testing
import TipKit

@Suite("ContentViewModel tests")
struct ContentViewModelTests {
    // MARK: - Private Properties

    private let sut: ContentViewModel
    private let sourcesRepositoryMock: SourcesRepositoryMock
    private let topHeadlinesRepositoryMock: TopHeadlinesRepositoryMock

    // MARK: - Lifecycles

    init() {
        sourcesRepositoryMock = SourcesRepositoryMock()
        topHeadlinesRepositoryMock = TopHeadlinesRepositoryMock()
        sut = ContentViewModel(deleteSourcesUseCase: DeleteSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
                               fetchSourcesUseCase: FetchSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
                               readSourcesUseCase: ReadSourcesUseCase(sourcesRepository: sourcesRepositoryMock),
                               deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
                               fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
                               readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock))
    }

    // MARK: - Methods

    @Test("Check ContentViewModel initializing!")
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
        #expect(contentViewModel != nil,
                "ContentViewModel initializing failed!")
    }

    @Test("Check ContentViewModel onAppear!")
    @MainActor
    func testOnAppear() async {
        // Given
        sut.selectedCountry = "uk"
        // When
        await sut.onAppear(selectedCountry: sut.selectedCountry)
        // Then
        #expect(sut.articles.count == 1 &&
            sut.countries.count == 1 &&
            sut.stateSources == .loaded &&
            sut.stateTopHeadlines == .loaded,
            "ContentViewModel onAppear failed!")
    }

    @Test("Check ContentViewModel fetchSources!")
    @MainActor
    func testFetchSources() async {
        // Given
        sut.countries = [EntityMock.sources.sources?.first?.country ?? "uk"]
        sut.selectedCountry = "uk"
        // When
        await sut.fetchSources()
        // Then
        #expect(sut.countries.count == 1,
                "ContentViewModel fetchSources failed!")
    }

    @Test("Check ContentViewModel fetchTopHeadlines!")
    @MainActor
    func testFetchTopHeadlines() async {
        // Given
        sut.articles = EntityMock.topHeadlines.articles ?? []
        sut.selectedCountry = "uk"
        // When
        await sut.fetchTopHeadlines(state: .isLoading)
        // Then
        #expect(sut.articles.count == 1,
                "ContentViewModel fetchTopHeadlines failed!")
    }

    @Test("Check ContentViewModel showSettingsTip!")
    func testShowSettingsTip() throws {
        // Given
        ContentViewModel.SettingsTip.show = false
        // When
        try sut.showSettingsTip()
        // Then
        #expect(ContentViewModel.SettingsTip.show,
                "ContentViewModel showSettingsTip failed!")
    }

    @Test("Check ContentViewModel reset!")
    @MainActor
    func testReset() async {
        // Given
        sut.apiKeyVersion = 2
        sut.articles = EntityMock.topHeadlines.articles ?? []
        sut.countries = [EntityMock.sources.sources?.first?.country ?? "uk"]
        sut.selectedCountry = "uk"
        sut.stateSources = .loaded
        sut.stateTopHeadlines = .loaded
        sut.translate = true
        sut.translateDisabled = false
        // When
        await sut.reset()
        // Then
        #expect(sut.apiKeyVersion == 1 &&
            sut.articles.isEmpty &&
            sut.countries.isEmpty &&
            sut.selectedCountry.isEmpty &&
            sut.stateSources == .emptyRead &&
            sut.stateTopHeadlines == .emptyRead &&
            !sut.translate &&
            sut.translateDisabled,
            "ContentViewModel reset failed!")
    }

    @Test("Check ContentViewModel translateConfiguration!")
    @MainActor
    func testTranslateConfiguration() async {
        // Given
        sut.translate = true
        sut.translationSessionConfiguration = nil
        // When
        await sut.translateConfiguration()
        // Then
        #expect(sut.translate &&
            sut.translationSessionConfiguration != nil,
            "ContentViewModel translateConfiguration failed!")
    }
}
