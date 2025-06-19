//
//  ViewModelFactoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

import Testing

@Suite("ViewModelFactory tests")
struct ViewModelFactoryTests {
    // MARK: - Private Properties

    private let sut = ViewModelFactory()

    // MARK: - Methods

    @Test("Check ContentViewModel initializing!")
    func contentViewModelIsNotNil() {
        // Given
        let contentViewModel: ContentViewModel?
        // When
        contentViewModel = sut.contentViewModel()
        // Then
        #expect(
            contentViewModel != nil,
            "ContentViewModel initializing failed!"
        )
    }

    @Test("Check DetailViewModel initializing!")
    func detailViewModelIsNotNil() {
        // Given
        let detailViewModel: DetailViewModel?
        // When
        detailViewModel = sut.detailViewModel(
            article: EntityMock.article,
            articleImage: nil
        )
        // Then
        #expect(
            detailViewModel != nil,
            "DetailViewModel initializing failed!"
        )
    }
}
