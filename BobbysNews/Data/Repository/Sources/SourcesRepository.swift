//
//  SourcesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 07.09.23.
//

import Foundation

protocol PSourcesRepository {

	// MARK: - Actions

	func fetch(apiKey: String) async throws -> SourcesApi
}

class SourcesRepository: PSourcesRepository {

	// MARK: - Actions

	func fetch(apiKey: String) async throws -> SourcesApi {
		let endpoint = "top-headlines/sources?apiKey=\(apiKey)"
		guard let url = URL(string: AppConfiguration.apiBaseUrl + endpoint) else {
			throw AppConfiguration.Errors.fetchSources
		}
		let (data, response) = try await URLSession.shared.data(from: url)
		try AppConfiguration.shared.validateResponse(defaultError: .fetchSources,
													 response: response as? HTTPURLResponse)
		return try JSONDecoder().decode(SourcesApi.self,
										from: data)
	}
}
