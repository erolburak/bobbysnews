//
//  ContentViewModelTests.swift
//  ContentViewModelTests
//
//  Created by Burak Erol on 31.08.23.
//

@testable import BobbysNews
import XCTest

class ContentViewModelTests: XCTestCase {

	private var sut: ContentViewModel!

	override func setUpWithError() throws {
		sut = ViewModelDI.shared.contentViewModel()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testOnAppear() async {
		// Given
		sut.selectedCountry = .none
		sut.state = .isLoading
		// When
		sut.onAppear()
		// Then
		await fulfillment(of: [], timeout: 1)
		XCTAssertEqual(sut.state, .noSelectedCountry)
	}

	func testDelete() {
		// Given
		sut.state = .loaded
		// When
		sut.delete()
		// Then
		XCTAssertEqual(sut.state, .emptyData)
	}

	func testFetchTopHeadlines() async {
		// Given
		sut.selectedCountry = .none
		sut.state = .isLoading
		// When
		await sut.fetchTopHeadlines(state: .isLoading)
		// Then
		XCTAssertEqual(sut.state, .noSelectedCountry)
	}

	func testShowAlerts() {
		for error in AppConfiguration.Errors.allCases {
			testShowAlertIsNotNil(error: error)
		}
	}

	private func testShowAlertIsNotNil(error: AppConfiguration.Errors) {
		// Given
		sut.showAlert = false
		// When
		sut.showAlert(error: error)
		// Then
		XCTAssertTrue(sut.showAlert)
		XCTAssertEqual(sut.alertError, error)
		XCTAssertNotNil(sut.alertError?.errorDescription)
		XCTAssertNotNil(sut.alertError?.recoverySuggestion)
	}
}
