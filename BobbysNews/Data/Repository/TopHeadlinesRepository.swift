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
			.tryMap { [weak self] data, response in
				try self?.validateResponse(defaultError: .fetch,
										   response: response as? HTTPURLResponse)
				return data
			}
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
			.tryMap { [weak self] data, response in
				try self?.validateResponse(defaultError: .fetchSources,
										   response: response as? HTTPURLResponse)
				return data
			}
			.decode(type: SourcesDTO.self,
					decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}

	private func validateResponse(defaultError: AppConfiguration.Errors,
								  response: HTTPURLResponse?) throws {
		guard let response,
			  200..<300 ~= response.statusCode else {
			switch response?.statusCode {
			case 401:
				throw AppConfiguration.Errors.invalidApiKey
			case 429:
				throw AppConfiguration.Errors.limitedRequests
			default:
				throw AppConfiguration.Errors.fetch
			}
		}
	}
}
