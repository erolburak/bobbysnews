//
//  TopHeadlinesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Combine
import Foundation

protocol PTopHeadlinesRepository {
	func fetch(country: String) -> AnyPublisher<TopHeadlinesDTO, Error>
	func fetchSources() -> AnyPublisher<SourcesDTO, Error>
}

class TopHeadlinesRepository: PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(country: String) -> AnyPublisher<TopHeadlinesDTO, Error> {
		let endpoint = "top-headlines?country=\(country)&apiKey=\(AppConfiguration.apiKey)"
		guard let url = URL(string: AppConfiguration.apiBaseUrl + endpoint) else {
			return Fail(error: AppConfiguration.Errors.fetch)
				.eraseToAnyPublisher()
		}
		return URLSession.shared.dataTaskPublisher(for: url)
			.map(\.data)
			.decode(type: TopHeadlinesDTO.self,
					decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}

	func fetchSources() -> AnyPublisher<SourcesDTO, Error> {
		let endpoint = "top-headlines/sources?apiKey=\(AppConfiguration.apiKey)"
		guard let url = URL(string: AppConfiguration.apiBaseUrl + endpoint) else {
			return Fail(error: AppConfiguration.Errors.fetchSources)
				.eraseToAnyPublisher()
		}
		return URLSession.shared.dataTaskPublisher(for: url)
			.map(\.data)
			.decode(type: SourcesDTO.self,
					decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}
