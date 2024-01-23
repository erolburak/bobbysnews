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

	// MARK: - Actions

	override func setUpWithError() throws {
		sut = ViewModelDI.shared.detailViewModel(article: Article(from: EntityMock.articleEntity1))
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testDetailViewModelIsNotNil() {
		// Given
		let articleEntity = EntityMock.articleEntity1
		// When
		let detailViewModel = DetailViewModel(article: Article(from: articleEntity))
		// Then
		XCTAssertNotNil(detailViewModel)
	}
}
