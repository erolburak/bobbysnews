//
//  DetailViewModelTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 31.08.23.
//

@testable import BobbysNews
import XCTest

class DetailViewModelTests: XCTestCase {

	private var sut: DetailViewModel!

	override func setUpWithError() throws {
		sut = ViewModelDI.shared.detailViewModel(article: Article(author: "Test",
																  content: "Test",
																  country: .germany,
																  publishedAt: Date.now,
																  source: Source(id: "Test",
																				 name: "Test"),
																  story: "Test",
																  title: "Test",
																  url: URL(string: "Test"),
																  urlToImage: URL(string: "Test")))
	}

	override func tearDownWithError() throws {
		sut = nil
	}
}
