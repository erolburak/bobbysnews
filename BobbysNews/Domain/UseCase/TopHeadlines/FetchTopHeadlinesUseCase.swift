//
//  FetchTopHeadlinesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 01.09.23.
//

import Combine

protocol PFetchTopHeadlinesUseCase {

	// MARK: - Actions

	func fetch(country: String) -> AnyPublisher<TopHeadlinesDTO, Error>
}

class FetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Life Cycle

	init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	func fetch(country: String) -> AnyPublisher<TopHeadlinesDTO, Error> {
		topHeadlinesRepository
			.fetch(country: country)
			.eraseToAnyPublisher()
	}
}
