//
//  TopHeadlinesNetworkController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

protocol PTopHeadlinesNetworkController {

	// MARK: - Actions

	func fetch(apiKey: Int,
			   country: String) async throws -> TopHeadlinesAPI
}

final class TopHeadlinesNetworkController: PTopHeadlinesNetworkController {

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
		return try JSONDecoder().decode(TopHeadlinesAPI.self,
										from: data)
	}
}
