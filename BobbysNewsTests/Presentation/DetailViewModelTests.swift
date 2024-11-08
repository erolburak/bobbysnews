//
//  DetailViewModelTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 31.08.23.
//

import Testing

@Suite("DetailViewModel tests")
struct DetailViewModelTests {
    // MARK: - Private Properties

    private let sut: DetailViewModel

    // MARK: - Lifecycles

    init() {
        sut = DetailViewModel(article: EntityMock.article,
                              articleImage: nil)
    }

    // MARK: - Methods

    @Test("Check DetailViewModel initializing!")
    func testDetailViewModel() {
        // Given
        let detailViewModel: DetailViewModel?
        // When
        detailViewModel = DetailViewModel(article: EntityMock.article,
                                          articleImage: nil)
        // Then
        #expect(detailViewModel != nil,
                "DetailViewModel initializing failed!")
    }

    @Test("Check DetailViewModel onAppear!")
    @MainActor
    func testOnAppear() async {
        // Given
        let article = EntityMock.article
        // When
        await sut.onAppear()
        // Then
        #expect(sut.article.author == article.author &&
            sut.article.content == article.content &&
            sut.article.contentTranslated == nil &&
            sut.article.publishedAt == article.publishedAt &&
            sut.article.showTranslations == article.showTranslations &&
            sut.article.source?.category == article.source?.category &&
            sut.article.source?.country == article.source?.country &&
            sut.article.source?.id == article.source?.id &&
            sut.article.source?.language == article.source?.language &&
            sut.article.source?.name == article.source?.name &&
            sut.article.source?.story == article.source?.story &&
            sut.article.source?.url == article.source?.url &&
            sut.article.story == article.story &&
            sut.article.title == article.title &&
            sut.article.titleTranslated == nil &&
            sut.article.url == article.url &&
            sut.article.urlToImage == article.urlToImage &&
            sut.articleContent == article.content &&
            sut.articleImage == nil &&
            sut.articleTitle == article.title &&
            !sut.showWebView &&
            sut.stateWebView == .isLoading &&
            sut.title == article.source?.name,
            "DetailViewModel onAppear failed!")
    }
}
