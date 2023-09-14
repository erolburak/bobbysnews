//
//  SourcesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 07.09.23.
//

import Combine
import Foundation

protocol PSourcesRepository {

	// MARK: - Actions

	func fetch(apiKey: String) -> AnyPublisher<SourcesDTO, Error>
}

class SourcesRepository: PSourcesRepository {

	// MARK: - Actions

	func fetch(apiKey: String) -> AnyPublisher<SourcesDTO, Error> {
		let endpoint = "top-headlines/sources?apiKey=\(apiKey)"
		guard let url = URL(string: AppConfiguration.apiBaseUrl + endpoint) else {
			return Fail(error: AppConfiguration.Errors.fetchSources)
				.eraseToAnyPublisher()
		}
		return URLSession.shared.dataTaskPublisher(for: url)
			.tryMap { data, response in
				try AppConfiguration.shared.validateResponse(defaultError: .fetchSources,
															 response: response as? HTTPURLResponse)
				return data
			}
			.decode(type: SourcesDTO.self,
					decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}
