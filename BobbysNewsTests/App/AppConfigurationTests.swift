//
//  AppConfigurationTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews
import XCTest

class AppConfigurationTests: XCTestCase {
	
	// MARK: - Private Properties
	
	private var sut: AppConfiguration!
	
	// MARK: - Life Cycle
	
	override func setUpWithError() throws {
		sut = AppConfiguration()
	}
	
	override func tearDownWithError() throws {
		sut = nil
	}
	
	// MARK: - Actions

	func testApiBaseUrl() {
		// Given
		let apiBaseUrl: String?
		// When
		apiBaseUrl = AppConfiguration.apiBaseUrl
		// Then
		XCTAssertNotNil(apiBaseUrl)
	}

	func testApiKey() {
		// Given
		let apiKey: String?
		// When
		apiKey = AppConfiguration.apiKey(1)
		// Then
		XCTAssertNotNil(apiKey)
	}

	func testValidateResponse() throws {
		// Given
		let response = HTTPURLResponse(url: URL(string: "Test")!,
									   statusCode: 200,
									   httpVersion: nil,
									   headerFields: nil)
		// Then
		XCTAssertNoThrow(try sut.validateResponse(defaultError: .error("Test"),
												  response: response))
	}

	func testValidateResponseThrowsError() throws {
		// Given
		let response = HTTPURLResponse(url: URL(string: "Test")!,
									   statusCode: 401,
									   httpVersion: nil,
									   headerFields: nil)
		// Then
		XCTAssertThrowsError(try sut.validateResponse(defaultError: .error("Test"),
													  response: response))
	}

	func testErrors() {
		for error in AppConfiguration.Errors.allCases {
			testErrorIsNotNil(error: error)
			print(error)
		}
	}

	private func testErrorIsNotNil(error: AppConfiguration.Errors) {
		// Given
		let description: String?
		let recoverySuggestion: String?
		// When
		description = error.errorDescription
		recoverySuggestion = error.recoverySuggestion
		// Then
		print(error)
		XCTAssertNotNil(description)
		XCTAssertNotNil(recoverySuggestion)
	}
}
