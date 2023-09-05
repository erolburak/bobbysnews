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
		sut.selectedCountry = ""
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// When
		sut.onAppear(country: "")
		// Then
		await fulfillment(of: [], timeout: 1)
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .isLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isLoading)
	}

	func testDelete() {
		// Given
		sut.selectedCountry = "Test"
		sut.stateSources = .loaded
		sut.stateTopHeadlines = .loaded
		// When
		sut.delete()
		// Then
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .emptyRead)
		XCTAssertEqual(sut.stateTopHeadlines, .emptyRead)
	}

	func testFetchTopHeadlines() async {
		// Given
		sut.selectedCountry = ""
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// When
		await sut.fetchTopHeadlines()
		// Then
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .isLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isLoading)
	}

	func testFetchTopHeadlinesSources() async {
		// Given
		sut.selectedCountry = ""
		sut.stateSources = .isLoading
		sut.stateTopHeadlines = .isLoading
		// When
		await sut.fetchTopHeadlinesSources()
		// Then
		XCTAssertTrue(sut.selectedCountry.isEmpty)
		XCTAssertEqual(sut.stateSources, .isLoading)
		XCTAssertEqual(sut.stateTopHeadlines, .isLoading)
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
