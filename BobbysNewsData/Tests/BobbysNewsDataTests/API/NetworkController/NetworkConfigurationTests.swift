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

    // MARK: - Methods

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

    @Test("Check NetworkConfiguration validateResponse with error!")
    func testValidateResponseWithError() {
        // Given
        let response = HTTPURLResponse(url: URL(string: "Test")!,
                                       statusCode: 401,
                                       httpVersion: nil,
                                       headerFields: nil)
        // Then
        #expect(throws: Error.self,
                "NetworkConfiguration validateResponse with error failed!")
        {
            try sut.validateResponse(defaultError: .fetchSources,
                                     response: response)
        }
    }

    @Test("Check NetworkConfiguration validateResponse with success!")
    func testValidateResponseWithSuccess() {
        // Given
        let response = HTTPURLResponse(url: URL(string: "Test")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        // Then
        #expect(throws: Never.self,
                "NetworkConfiguration validateResponse with success failed!")
        {
            try sut.validateResponse(defaultError: .fetchSources,
                                     response: response)
        }
    }
}
