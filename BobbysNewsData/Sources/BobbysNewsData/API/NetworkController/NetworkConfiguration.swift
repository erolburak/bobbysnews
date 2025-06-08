//
//  NetworkConfiguration.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 24.01.24.
//

import Foundation

struct NetworkConfiguration {
    // MARK: - Properties

    static let apiBaseUrl = URL(string: "https://gnews.io/api/v4/")
    static let shared = NetworkConfiguration()

    // MARK: - Methods

    func validateResponse(defaultError: ErrorsAPI,
                          response: HTTPURLResponse?) throws
    {
        guard let response,
              200 ..< 300 ~= response.statusCode
        else {
            switch response?.statusCode {
            case 400:
                throw ErrorsAPI.badRequest
            case 401:
                throw ErrorsAPI.unauthorized
            case 403:
                throw ErrorsAPI.forbidden
            case 429:
                throw ErrorsAPI.tooManyRequests
            case 500:
                throw ErrorsAPI.internalServerError
            case 503:
                throw ErrorsAPI.serviceUnavailable
            default:
                throw defaultError
            }
        }
    }
}
