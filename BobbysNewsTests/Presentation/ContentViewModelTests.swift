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
    private let topHeadlinesRepositoryMock: TopHeadlinesRepositoryMock

    // MARK: - Lifecycles

    init() {
        topHeadlinesRepositoryMock = TopHeadlinesRepositoryMock()
        sut = ContentViewModel(deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
                               fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
                               readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock))
    }

    // MARK: - Methods

    @Test("Check ContentViewModel initializing!")
    func contentViewModel() {
        // Given
        let contentViewModel: ContentViewModel?
        // When
        contentViewModel = ContentViewModel(deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
                                            fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock),
                                            readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesRepository: topHeadlinesRepositoryMock))
        // Then
        #expect(contentViewModel != nil,
                "ContentViewModel initializing failed!")
    }

    @Test("Check ContentViewModel onAppear!")
    func onAppear() {
        // Given
        sut.selectedApiKey = "Test"
        sut.selectedCategory = .general
        sut.selectedCountry = "Test"
        // When
        sut.onAppear(selectedApiKey: sut.selectedApiKey,
                     selectedCategory: sut.selectedCategory,
                     selectedCountry: sut.selectedCountry)
        // Then
        #expect(sut.articles.count == 1 &&
            !sut.categoriesSorted.isEmpty &&
            !sut.countriesSorted.isEmpty &&
            sut.state == .loaded,
            "ContentViewModel onAppear failed!")
    }

    @Test("Check ContentViewModel configureTranslations!")
    @MainActor
    func configureTranslations() async {
        // Given
        sut.translate = true
        sut.translationSessionConfiguration = nil
        // When
        await sut.configureTranslations()
        // Then
        #expect(sut.translate &&
            sut.translationSessionConfiguration != nil,
            "ContentViewModel translateConfiguration failed!")
    }

    @Test("Check ContentViewModel fetchTopHeadlines!")
    @MainActor
    func fetchTopHeadlines() async {
        // Given
        sut.articles = EntityMock.topHeadlines.articles ?? []
        sut.selectedApiKey = "Test"
        sut.selectedCategory = .general
        sut.selectedCountry = "Test"
        // When
        await sut.fetchTopHeadlines(state: .isLoading)
        // Then
        #expect(sut.articles.count == 1,
                "ContentViewModel fetchTopHeadlines failed!")
    }

    @Test("Check ContentViewModel showSettingsTip!")
    func showSettingsTip() {
        // Given
        ContentViewModel.SettingsTip.show = false
        // When
        sut.showSettingsTip()
        // Then
        #expect(ContentViewModel.SettingsTip.show,
                "ContentViewModel showSettingsTip failed!")
    }

    @Test("Check ContentViewModel reset!")
    @MainActor
    func reset() async {
        // Given
        sut.articles = EntityMock.topHeadlines.articles ?? []
        sut.countries = [EntityMock.article.country ?? "Test"]
        sut.selectedApiKey = "Test"
        sut.selectedCategory = .business
        sut.selectedCountry = "Test"
        sut.state = .loaded
        sut.translate = true
        sut.translateDisabled = false
        // When
        await sut.reset()
        // Then
        #expect(sut.articles.isEmpty &&
            !sut.countries.isEmpty &&
            sut.selectedApiKey.isEmpty &&
            sut.selectedCategory == .general &&
            sut.selectedCountry.isEmpty &&
            sut.state == .emptyRead &&
            !sut.translate &&
            sut.translateDisabled,
            "ContentViewModel reset failed!")
    }
}
