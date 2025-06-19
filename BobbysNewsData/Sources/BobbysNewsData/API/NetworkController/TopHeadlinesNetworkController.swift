//
//  TopHeadlinesNetworkController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

protocol PTopHeadlinesNetworkController: Sendable {
    // MARK: - Methods

    func fetch(
        apiKey: String,
        category: String,
        country: String
    ) async throws -> TopHeadlinesAPI
}

final class TopHeadlinesNetworkController: PTopHeadlinesNetworkController {
    // MARK: - Private Properties

    private let jsonDecoder = JSONDecoder()

    // MARK: - Lifecycles

    init() {
        jsonDecoder.dateDecodingStrategy = .iso8601
    }

    // MARK: - Methods

    func fetch(
        apiKey: String,
        category: String,
        country: String
    ) async throws -> TopHeadlinesAPI {
        guard
            let url = NetworkConfiguration.apiBaseUrl?
                .appending(path: "top-headlines")
                .appending(queryItems: [
                    URLQueryItem(
                        name: "category",
                        value: category),
                    URLQueryItem(
                        name: "country",
                        value: country),
                    URLQueryItem(
                        name: "apikey",
                        value: apiKey),
                ])
        else {
            throw ErrorsAPI.badRequest
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        try NetworkConfiguration.shared.validateResponse(
            defaultError: .badRequest,
            response: response as? HTTPURLResponse
        )
        return try jsonDecoder.decode(
            TopHeadlinesAPI.self,
            from: data
        )
    }
}
