//
//  TopHeadlinesNetworkController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

protocol PTopHeadlinesNetworkController: Sendable {

	// MARK: - Actions

	func fetch(apiKey: Int,
			   country: String) async throws -> TopHeadlinesAPI
}

final class TopHeadlinesNetworkController: PTopHeadlinesNetworkController {

	// MARK: - Private Properties

	private let jsonDecoder = JSONDecoder()

	// MARK: - Inits

	init() {
		jsonDecoder.dateDecodingStrategy = .iso8601
	}

	// MARK: - Actions

	func fetch(apiKey: Int,
			   country: String) async throws -> TopHeadlinesAPI {
		let endpoint = "top-headlines?country=\(country)&apiKey=\(NetworkConfiguration.apiKey(apiKey))"
		guard let url = URL(string: NetworkConfiguration.apiBaseUrl + endpoint) else {
			throw NetworkConfiguration.Errors.fetchTopHeadlines
		}
		let (data, response) = try await URLSession.shared.data(from: url)
		try NetworkConfiguration.shared.validateResponse(defaultError: .fetchTopHeadlines,
													  response: response as? HTTPURLResponse)
		return try jsonDecoder.decode(TopHeadlinesAPI.self,
									  from: data)
	}
}
