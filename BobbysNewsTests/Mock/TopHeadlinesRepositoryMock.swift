//
//  TopHeadlinesRepositoryMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine

class TopHeadlinesRepositoryMock: PTopHeadlinesRepository {

	// MARK: - Actions

	func fetch(country: String) -> AnyPublisher<TopHeadlinesDTO, Error> {
		if country.isEmpty == false {
			return Just(DTOMock.topHeadlinesDto)
				.setFailureType(to: Error.self)
				.eraseToAnyPublisher()
		} else {
			return Fail<TopHeadlinesDTO, Error>(error: AppConfiguration.Errors.fetch)
				.eraseToAnyPublisher()
		}
	}

	func fetchSources() -> AnyPublisher<SourcesDTO, Error> {
		Just(DTOMock.sourcesDto)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
}
