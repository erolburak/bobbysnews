//
//  NetworkConfigurationTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import XCTest

class NetworkConfigurationTests: XCTestCase {
	
	// MARK: - Private Properties
	
	private var sut: NetworkConfiguration!
	
	// MARK: - Actions
	
	override func setUpWithError() throws {
		sut = NetworkConfiguration()
	}
	
	override func tearDownWithError() throws {
		sut = nil
	}

	func testApiBaseUrl() {
		// Given
		let apiBaseUrl: String?
		// When
		apiBaseUrl = NetworkConfiguration.apiBaseUrl
		// Then
		XCTAssertNotNil(apiBaseUrl)
	}

	func testApiKey() {
		// Given
		let apiKey: String?
		// When
		apiKey = NetworkConfiguration.apiKey(1)
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
		XCTAssertNoThrow(try sut.validateResponse(defaultError: .fetchSources,
												  response: response))
	}

	func testValidateResponseThrowsError() throws {
		// Given
		let response = HTTPURLResponse(url: URL(string: "Test")!,
									   statusCode: 401,
									   httpVersion: nil,
									   headerFields: nil)
		// Then
		XCTAssertThrowsError(try sut.validateResponse(defaultError: .fetchSources,
													  response: response))
	}
}
