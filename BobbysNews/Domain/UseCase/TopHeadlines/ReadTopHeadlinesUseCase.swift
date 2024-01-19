//
//  ReadTopHeadlinesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine

protocol PReadTopHeadlinesUseCase {

	// MARK: - Actions

	func read() -> AnyPublisher<TopHeadlines, Error>
}

class ReadTopHeadlinesUseCase: PReadTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository

	// MARK: - Inits

	init(topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository) {
		self.topHeadlinesQueriesRepository = topHeadlinesQueriesRepository
	}

	// MARK: - Actions

	func read() -> AnyPublisher<TopHeadlines, Error> {
		topHeadlinesQueriesRepository
			.read()
			.eraseToAnyPublisher()
	}
}
