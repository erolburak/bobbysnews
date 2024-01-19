//
//  DeleteSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 07.09.23.
//

import Combine

protocol PDeleteSourcesUseCase {

	// MARK: - Actions

	func delete() throws
}

class DeleteSourcesUseCase: PDeleteSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesQueriesRepository: PSourcesQueriesRepository

	// MARK: - Inits

	init(sourcesQueriesRepository: PSourcesQueriesRepository) {
		self.sourcesQueriesRepository = sourcesQueriesRepository
	}

	// MARK: - Actions

	func delete() throws {
		try sourcesQueriesRepository
			.delete()
	}
}
