//
//  ViewModelFactoryTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ViewModelFactoryTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: ViewModelFactory!

	// MARK: - Actions

	override func setUpWithError() throws {
		sut = ViewModelFactory()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testContentViewModelIsNotNil() {
		// Given
		let contentViewModel: ContentViewModel?
		// When
		contentViewModel = sut.contentViewModel()
		// Then
		XCTAssertNotNil(contentViewModel)
	}

	func testDetailViewModelIsNotNil() {
		// Given
		let detailViewModel: DetailViewModel?
		// When
		detailViewModel = sut.detailViewModel(article: EntityMock.article1)
		// Then
		XCTAssertNotNil(detailViewModel)
	}
}
