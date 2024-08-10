//
//  NetworkConfigurationTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

struct NetworkConfigurationTests {

	// MARK: - Private Properties

	private let sut = NetworkConfiguration()

	// MARK: - Actions

	@Test("Check NetworkConfiguration apiBaseUrl!")
	func testApiBaseUrl() {
		// Given
		let apiBaseUrl: String?
		// When
		apiBaseUrl = NetworkConfiguration.apiBaseUrl
		// Then
		#expect(apiBaseUrl != nil,
				"NetworkConfiguration apiBaseUrl failed!")
	}

	@Test("Check NetworkConfiguration apiKey!")
	func testApiKey() {
		// Given
		let apiKey: String?
		// When
		apiKey = NetworkConfiguration.apiKey(1)
		// Then
		#expect(apiKey != nil,
				"NetworkConfiguration apiKey failed!")
	}

	@Test("Check NetworkConfiguration validateResponse!")
	func testValidateResponse() {
		// Given
		let response = HTTPURLResponse(url: URL(string: "Test")!,
									   statusCode: 200,
									   httpVersion: nil,
									   headerFields: nil)
		// Then
		#expect(throws: Never.self,
				"NetworkConfiguration validateResponse failed!") {
			try sut.validateResponse(defaultError: .fetchSources,
									 response: response)
		}
	}

	@Test("Check NetworkConfiguration validateResponseThrowsError!")
	func testValidateResponseThrowsError() {
		// Given
		let response = HTTPURLResponse(url: URL(string: "Test")!,
									   statusCode: 401,
									   httpVersion: nil,
									   headerFields: nil)
		// Then
		#expect(throws: Error.self,
				"NetworkConfiguration validateResponseThrowsError failed!") {
			try sut.validateResponse(defaultError: .fetchSources,
									 response: response)
		}
	}
}
