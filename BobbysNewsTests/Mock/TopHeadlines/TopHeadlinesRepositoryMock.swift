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

	func fetch(apiKey: String,
			   country: String) -> AnyPublisher<TopHeadlinesDTO, Error> {
		if country.isEmpty == false {
			return Just(DTOMock.topHeadlinesDto1)
				.setFailureType(to: Error.self)
				.eraseToAnyPublisher()
		} else {
			return Fail<TopHeadlinesDTO, Error>(error: AppConfiguration.Errors.fetch)
				.eraseToAnyPublisher()
		}
	}
}
