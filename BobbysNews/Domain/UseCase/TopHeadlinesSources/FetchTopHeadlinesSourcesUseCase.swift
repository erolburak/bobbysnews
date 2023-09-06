//
//  FetchTopHeadlinesSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import Combine

protocol PFetchTopHeadlinesSourcesUseCase {

	// MARK: - Actions

	func fetchSources() -> AnyPublisher<SourcesDTO, Error>
}

class FetchTopHeadlinesSourcesUseCase: PFetchTopHeadlinesSourcesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesRepository: PTopHeadlinesRepository

	// MARK: - Life Cycle

	init(topHeadlinesRepository: PTopHeadlinesRepository) {
		self.topHeadlinesRepository = topHeadlinesRepository
	}

	// MARK: - Actions

	func fetchSources() -> AnyPublisher<SourcesDTO, Error> {
		topHeadlinesRepository
			.fetchSources()
			.eraseToAnyPublisher()
	}
}
