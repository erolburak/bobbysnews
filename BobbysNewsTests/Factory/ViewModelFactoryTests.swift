//
//  ViewModelFactoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

import Testing

struct ViewModelFactoryTests {
    // MARK: - Private Properties

    private let sut = ViewModelFactory()

    // MARK: - Methods

    @Test("Check ContentViewModel initializing!")
    func testContentViewModelIsNotNil() {
        // Given
        let contentViewModel: ContentViewModel?
        // When
        contentViewModel = sut.contentViewModel()
        // Then
        #expect(contentViewModel != nil,
                "ContentViewModel initializing failed!")
    }

    @Test("Check DetailViewModel initializing!")
    func testDetailViewModelIsNotNil() {
        // Given
        let detailViewModel: DetailViewModel?
        // When
        detailViewModel = sut.detailViewModel(article: EntityMock.article,
                                              articleImage: nil)
        // Then
        #expect(detailViewModel != nil,
                "DetailViewModel initializing failed!")
    }
}
