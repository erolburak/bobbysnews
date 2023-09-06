//
//  ViewModelDITests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ViewModelDITests: XCTestCase {

	// MARK: - Private Properties

	private var sut: ViewModelDI!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		sut = ViewModelDI()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	// MARK: - Actions

	func testContentViewModelIsNotNil() {
		// When
		let contentViewModel = sut.contentViewModel()
		// Then
		XCTAssertNotNil(contentViewModel)
	}

	func testDetailViewModelIsNotNil() {
		// Given
		let article = EntityMock.article1
		// When
		let detailViewModel = sut.detailViewModel(article: article)
		// Then
		XCTAssertNotNil(detailViewModel)
	}
}
