//
//  DeleteTopHeadlinesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 04.09.23.
//

import Combine

protocol PDeleteTopHeadlinesUseCase {

	// MARK: - Actions

	func delete() throws
}

class DeleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository

	// MARK: - Life Cycle

	init(topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository) {
		self.topHeadlinesQueriesRepository = topHeadlinesQueriesRepository
	}

	// MARK: - Actions

	func delete() throws {
		try topHeadlinesQueriesRepository
			.delete()
	}
}
