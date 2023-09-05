//
//  ReadTopHeadlinesSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import Combine

protocol PReadTopHeadlinesSourcesUseCase {
	func readSources() -> AnyPublisher<Sources, Error>
}

class ReadTopHeadlinesSourcesUseCase: PReadTopHeadlinesSourcesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository

	// MARK: - Life Cycle

	init(topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository) {
		self.topHeadlinesQueriesRepository = topHeadlinesQueriesRepository
	}

	// MARK: - Actions

	func readSources() -> AnyPublisher<Sources, Error> {
		topHeadlinesQueriesRepository
			.readSources()
			.eraseToAnyPublisher()
	}
}
