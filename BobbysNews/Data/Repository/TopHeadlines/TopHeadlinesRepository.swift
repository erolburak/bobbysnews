//
//  TopHeadlinesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

protocol PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) async throws -> TopHeadlinesApi
}

class TopHeadlinesRepository: PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) async throws -> TopHeadlinesApi {
		let endpoint = "top-headlines?country=\(country)&apiKey=\(apiKey)"
		guard let url = URL(string: AppConfiguration.apiBaseUrl + endpoint) else {
			throw AppConfiguration.Errors.fetchTopHeadlines
		}
		let (data, response) = try await URLSession.shared.data(from: url)
		try AppConfiguration.shared.validateResponse(defaultError: .fetchTopHeadlines,
													 response: response as? HTTPURLResponse)
		return try JSONDecoder().decode(TopHeadlinesApi.self,
										from: data)
	}
}
