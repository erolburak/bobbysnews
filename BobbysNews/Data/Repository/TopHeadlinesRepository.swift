//
//  TopHeadlinesRepository.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Combine
import Foundation

protocol PTopHeadlinesRepository {
	func fetch(country: Country) -> AnyPublisher<TopHeadlinesDTO, Error>
}

class TopHeadlinesRepository: PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(country: Country) -> AnyPublisher<TopHeadlinesDTO, Error> {
		let endpoint = "top-headlines?country=\(country.rawValue)&apiKey=\(AppConfiguration.apiKey)"
		guard let url = URL(string: AppConfiguration.apiBaseUrl + endpoint) else {
			return Fail(error: AppConfiguration.Errors.fetchTopHeadlines)
				.eraseToAnyPublisher()
		}
		return URLSession.shared.dataTaskPublisher(for: url)
			.map(\.data)
			.decode(type: TopHeadlinesDTO.self,
					decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}
