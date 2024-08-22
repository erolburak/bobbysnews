//
//  DetailViewModelTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 31.08.23.
//

import Testing

struct DetailViewModelTests {
    // MARK: - Methods

    @Test("Check DetailViewModel initializing!")
    func testDetailViewModel() {
        // Given
        let article = EntityMock.article
        let detailViewModel: DetailViewModel?
        // When
        detailViewModel = DetailViewModel(article: article)
        // Then
        #expect(detailViewModel != nil &&
            detailViewModel?.article.author == article.author &&
            detailViewModel?.article.content == article.content &&
            detailViewModel?.article.contentTranslation == nil &&
            detailViewModel?.article.publishedAt == article.publishedAt &&
            detailViewModel?.article.source?.category == article.source?.category &&
            detailViewModel?.article.source?.country == article.source?.country &&
            detailViewModel?.article.source?.id == article.source?.id &&
            detailViewModel?.article.source?.language == article.source?.language &&
            detailViewModel?.article.source?.name == article.source?.name &&
            detailViewModel?.article.source?.story == article.source?.story &&
            detailViewModel?.article.source?.url == article.source?.url &&
            detailViewModel?.article.story == article.story &&
            detailViewModel?.article.title == article.title &&
            detailViewModel?.article.titleTranslation == nil &&
            detailViewModel?.article.url == article.url &&
            detailViewModel?.article.urlToImage == article.urlToImage,
            "DetailViewModel initializing failed!")
    }
}
