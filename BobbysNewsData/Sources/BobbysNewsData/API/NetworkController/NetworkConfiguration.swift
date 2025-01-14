//
//  NetworkConfiguration.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 24.01.24.
//

import Foundation

struct NetworkConfiguration {
    // MARK: - Type Definitions

    enum Errors: LocalizedError {
        // MARK: - Properties

        case fetchSources, fetchTopHeadlines, invalidApiKey, limitedRequests
    }

    // MARK: - Private Properties

    private static let apiKeys = ["5cac74ed65174965aff2fff52f09a0bc",
                                  "3d4ebbcc8f4749349fb66bb21913f717",
                                  "eac8e350dc834a0c96e3a450e7e0c0ee",
                                  "57d956229c5449e58443c98196a38bef",
                                  "0b2e24b44e6a40e9af79e4f08ab57963"]

    // MARK: - Properties

    static let apiBaseUrl = "https://newsapi.org/v2/"
    static func apiKey(_ key: Int) -> String {
        apiKeys[key - 1]
    }

    static let shared = NetworkConfiguration()

    // MARK: - Methods

    func validateResponse(defaultError: Errors,
                          response: HTTPURLResponse?) throws
    {
        guard let response,
              200 ..< 300 ~= response.statusCode
        else {
            switch response?.statusCode {
            case 401:
                throw Errors.invalidApiKey
            case 429:
                throw Errors.limitedRequests
            default:
                throw defaultError
            }
        }
    }
}
