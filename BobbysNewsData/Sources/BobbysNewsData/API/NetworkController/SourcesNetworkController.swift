//
//  SourcesNetworkController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

import Foundation

protocol PSourcesNetworkController: Sendable {

	// MARK: - Actions

	func fetch(apiKey: Int) async throws -> SourcesAPI
}

final class SourcesNetworkController: PSourcesNetworkController {

	// MARK: - Private Properties

	private let jsonDecoder = JSONDecoder()

	// MARK: - Inits

	init() {
		jsonDecoder.dateDecodingStrategy = .iso8601
	}

	// MARK: - Actions

	func fetch(apiKey: Int) async throws -> SourcesAPI {
		let endpoint = "top-headlines/sources?apiKey=\(NetworkConfiguration.apiKey(apiKey))"
		guard let url = URL(string: NetworkConfiguration.apiBaseUrl + endpoint) else {
			throw NetworkConfiguration.Errors.fetchSources
		}
		let (data, response) = try await URLSession.shared.data(from: url)
		try NetworkConfiguration.shared.validateResponse(defaultError: .fetchSources,
													  response: response as? HTTPURLResponse)
		return try jsonDecoder.decode(SourcesAPI.self,
									  from: data)
	}
}
