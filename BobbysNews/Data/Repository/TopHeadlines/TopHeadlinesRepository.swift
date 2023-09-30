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
			   country: String) async throws -> TopHeadlinesDTO
}

class TopHeadlinesRepository: PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) async throws -> TopHeadlinesDTO {
		let endpoint = "top-headlines?country=\(country)&apiKey=\(apiKey)"
		guard let url = URL(string: AppConfiguration.apiBaseUrl + endpoint) else {
			throw AppConfiguration.Errors.fetchTopHeadlines
		}
		let (data, response) = try await URLSession.shared.data(from: url)
		try AppConfiguration.shared.validateResponse(defaultError: .fetchTopHeadlines,
													 response: response as? HTTPURLResponse)
		return try JSONDecoder().decode(TopHeadlinesDTO.self,
										from: data)
	}
}
