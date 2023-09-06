//
//  DetailViewModelTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 31.08.23.
//

@testable import BobbysNews
import XCTest

class DetailViewModelTests: XCTestCase {

	// MARK: - Private Properties

	private var sut: DetailViewModel!

	// MARK: - Life Cycle

	override func setUpWithError() throws {
		sut = ViewModelDI.shared.detailViewModel(article: EntityMock.article)
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	// MARK: - Actions

	func testDetailViewModelIsNotNil() async {
		// Given
		let article = EntityMock.article
		// When
		let detailViewModel = DetailViewModel(article: article)
		// Then
		XCTAssertNotNil(detailViewModel)
	}
}
