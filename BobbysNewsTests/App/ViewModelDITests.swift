//
//  ViewModelDITests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import XCTest

class ViewModelDITests: XCTestCase {

	private var sut: ViewModelDI!

	override func setUpWithError() throws {
		sut = ViewModelDI()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testContentViewModelIsNotNil() {
		// When
		let contentViewModel = sut.contentViewModel()
		// Then
		XCTAssertNotNil(contentViewModel)
	}

	func testDetailViewModelIsNotNil() {
		// Given
		let article = Article(author: "Test",
							  content: "Test",
							  country: "Test",
							  publishedAt: .now,
							  source: Source(category: "Test",
											 country: "Test",
											 id: "Test",
											 language: "Test",
											 name: "Test",
											 story: "Test",
											 url: URL(string: "Test")),
							  story: "Test",
							  title: "Test",
							  url: URL(string: "Test"),
							  urlToImage: URL(string: "Test"))
		// When
		let detailViewModel = sut.detailViewModel(article: article)
		// Then
		XCTAssertNotNil(detailViewModel)
	}
}
