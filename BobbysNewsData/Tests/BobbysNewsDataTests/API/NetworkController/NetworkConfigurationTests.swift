//
//  NetworkConfigurationTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
import Foundation
import Testing

@Suite("NetworkConfiguration tests")
struct NetworkConfigurationTests {
    // MARK: - Private Properties

    private let sut = NetworkConfiguration()

    // MARK: - Methods

    @Test("Check NetworkConfiguration apiBaseUrl!")
    func apiBaseUrl() {
        // Given
        let apiBaseUrl: URL?
        // When
        apiBaseUrl = NetworkConfiguration.apiBaseUrl
        // Then
        #expect(apiBaseUrl != nil,
                "NetworkConfiguration apiBaseUrl failed!")
    }

    @Test("Check NetworkConfiguration validateResponse with error!")
    func validateResponseWithError() {
        // Given
        let response = HTTPURLResponse(url: URL(string: "Test")!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: nil)
        // Then
        #expect(throws: Error.self,
                "NetworkConfiguration validateResponse with error failed!")
        {
            try sut.validateResponse(defaultError: .badRequest,
                                     response: response)
        }
    }

    @Test("Check NetworkConfiguration validateResponse with success!")
    func validateResponseWithSuccess() {
        // Given
        let response = HTTPURLResponse(url: URL(string: "Test")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)
        // Then
        #expect(throws: Never.self,
                "NetworkConfiguration validateResponse with success failed!")
        {
            try sut.validateResponse(defaultError: .badRequest,
                                     response: response)
        }
    }
}
