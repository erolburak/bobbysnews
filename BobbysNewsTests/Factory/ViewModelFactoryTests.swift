//
//  ViewModelFactoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

import Testing

struct ViewModelFactoryTests {

	// MARK: - Actions

	@Test("Check ContentViewModel initializing!")
	func testContentViewModelIsNotNil() {
		// Given
		let contentViewModel: ContentViewModel?
		// When
		contentViewModel = ViewModelFactory().contentViewModel()
		// Then
		#expect(contentViewModel != nil,
				"ContentViewModel initializing failed!")
	}

	@Test("Check DetailViewModel initializing!")
	func testDetailViewModelIsNotNil() {
		// Given
		let detailViewModel: DetailViewModel?
		// When
		detailViewModel = ViewModelFactory().detailViewModel(article: EntityMock.article)
		// Then
		#expect(detailViewModel != nil,
				"DetailViewModel initializing failed!")
	}
}
