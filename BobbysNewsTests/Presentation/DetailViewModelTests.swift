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
		sut = ViewModelFactory.shared.detailViewModel(article: EntityMock.article1)
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testDetailViewModel() {
		// Given
		let article = EntityMock.article2
		let detailViewModel: DetailViewModel?
		// When
		detailViewModel = DetailViewModel(article: article)
		// Then
		XCTAssertNotNil(detailViewModel)
		XCTAssertEqual(detailViewModel?.article.author, article.author)
		XCTAssertEqual(detailViewModel?.article.content, article.content)
		XCTAssertEqual(detailViewModel?.article.publishedAt, article.publishedAt)
		XCTAssertEqual(detailViewModel?.article.source?.category, article.source?.category)
		XCTAssertEqual(detailViewModel?.article.source?.country, article.source?.country)
		XCTAssertEqual(detailViewModel?.article.source?.id, article.source?.id)
		XCTAssertEqual(detailViewModel?.article.source?.language, article.source?.language)
		XCTAssertEqual(detailViewModel?.article.source?.name, article.source?.name)
		XCTAssertEqual(detailViewModel?.article.source?.story, article.source?.story)
		XCTAssertEqual(detailViewModel?.article.source?.url, article.source?.url)
		XCTAssertEqual(detailViewModel?.article.story, article.story)
		XCTAssertEqual(detailViewModel?.article.title, article.title)
		XCTAssertEqual(detailViewModel?.article.url, article.url)
		XCTAssertEqual(detailViewModel?.article.urlToImage, article.urlToImage)
	}
}
