//
//  TopHeadlinesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Combine
import Foundation

protocol PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) -> AnyPublisher<TopHeadlinesDTO, Error>
}

class TopHeadlinesRepository: PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(apiKey: String,
			   country: String) -> AnyPublisher<TopHeadlinesDTO, Error> {
		let endpoint = "top-headlines?country=\(country)&apiKey=\(apiKey)"
		guard let url = URL(string: AppConfiguration.apiBaseUrl + endpoint) else {
			return Fail(error: AppConfiguration.Errors.fetch)
				.eraseToAnyPublisher()
		}
		return URLSession.shared.dataTaskPublisher(for: url)
			.tryMap { data, response in
				try AppConfiguration.shared.validateResponse(defaultError: .fetch,
															 response: response as? HTTPURLResponse)
				return data
			}
			.decode(type: TopHeadlinesDTO.self,
					decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}
