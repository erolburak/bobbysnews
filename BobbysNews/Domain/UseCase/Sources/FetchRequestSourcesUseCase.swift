//
//  FetchRequestSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import Combine

protocol PFetchRequestSourcesUseCase {

	// MARK: - Actions

	func fetchRequest()
}

class FetchRequestSourcesUseCase: PFetchRequestSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesQueriesRepository: PSourcesQueriesRepository

	// MARK: - Inits

	init(sourcesQueriesRepository: PSourcesQueriesRepository) {
		self.sourcesQueriesRepository = sourcesQueriesRepository
	}

	// MARK: - Actions

	func fetchRequest() {
		sourcesQueriesRepository
			.fetchRequest()
	}
}
