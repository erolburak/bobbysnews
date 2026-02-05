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
        sut = DetailViewModel(
            article: EntityMock.article,
            articleImage: nil
        )
    }

    // MARK: - Methods

    @Test("Check DetailViewModel initializing!")
    func detailViewModel() {
        // Given
        let detailViewModel: DetailViewModel?
        // When
        detailViewModel = DetailViewModel(
            article: EntityMock.article,
            articleImage: nil
        )
        // Then
        #expect(
            detailViewModel != nil,
            "DetailViewModel initializing failed!"
        )
    }

    @Test("Check DetailViewModel onAppear!")
    @MainActor
    func onAppear() async {
        // Given
        let article = EntityMock.article
        // When
        await sut.onAppear()
        // Then
        #expect(
            sut.article.category == article.category && sut.article.content == article.content
                && sut.article.contentTranslated == nil && sut.article.image == article.image
                && sut.article.publishedAt == article.publishedAt
                && sut.article.showTranslations == article.showTranslations
                && sut.article.source?.name == article.source?.name
                && sut.article.source?.url == article.source?.url
                && sut.article.story == article.story && sut.article.title == article.title
                && sut.article.titleTranslated == nil && sut.article.url == article.url
                && sut.articleContent == article.content && sut.articleImage == nil
                && sut.articleTitle == article.title && !sut.showNoNetworkConnection
                && !sut.showWebView && sut.webPage == nil,
            "DetailViewModel onAppear failed!"
        )
    }

    @Test("Check DetailViewModel loadWebPage!")
    @MainActor
    func loadWebPage() {
        // Given
        sut.showWebView = true
        // When
        sut.loadWebPage()
        // Then
        #expect(
            sut.showWebView && sut.webPage != nil,
            "DetailViewModel loadWebPage failed!"
        )
    }
}
