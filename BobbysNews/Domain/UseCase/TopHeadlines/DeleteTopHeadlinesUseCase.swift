//
//  DeleteTopHeadlinesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 04.09.23.
//

import Combine

protocol PDeleteTopHeadlinesUseCase {

	// MARK: - Actions

	func delete(country: String?) throws
}

class DeleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository

	// MARK: - Inits

	init(topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository) {
		self.topHeadlinesQueriesRepository = topHeadlinesQueriesRepository
	}

	// MARK: - Actions

	func delete(country: String?) throws {
		try topHeadlinesQueriesRepository
			.delete(country: country)
	}
}
