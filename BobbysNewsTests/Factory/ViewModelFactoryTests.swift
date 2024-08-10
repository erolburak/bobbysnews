//
//  ViewModelFactoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

import Testing

@MainActor
struct ViewModelFactoryTests {

	// MARK: - Actions

	@Test("Check initializing ContentViewModel!")
	func testContentViewModelIsNotNil() {
		// Given
		let contentViewModel: ContentViewModel?
		// When
		contentViewModel = ViewModelFactory().contentViewModel()
		// Then
		#expect(contentViewModel != nil,
				"Initializing ContentViewModel failed!")
	}

	@Test("Check initializing DetailViewModel!")
	func testDetailViewModelIsNotNil() {
		// Given
		let detailViewModel: DetailViewModel?
		// When
		detailViewModel = ViewModelFactory().detailViewModel(article: EntityMock.article)
		// Then
		#expect(detailViewModel != nil,
				"Initializing DetailViewModel failed!")
	}
}
