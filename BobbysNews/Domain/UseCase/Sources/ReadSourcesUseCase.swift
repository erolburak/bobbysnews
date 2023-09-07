//
//  ReadSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import Combine

protocol PReadSourcesUseCase {

	// MARK: - Actions

	func read() -> AnyPublisher<Sources, Error>
}

class ReadSourcesUseCase: PReadSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesQueriesRepository: PSourcesQueriesRepository

	// MARK: - Life Cycle

	init(sourcesQueriesRepository: PSourcesQueriesRepository) {
		self.sourcesQueriesRepository = sourcesQueriesRepository
	}

	// MARK: - Actions

	func read() -> AnyPublisher<Sources, Error> {
		sourcesQueriesRepository
			.read()
			.eraseToAnyPublisher()
	}
}
