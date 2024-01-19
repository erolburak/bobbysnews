//
//  FetchRequestTopHeadlinesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine

protocol PFetchRequestTopHeadlinesUseCase {

	// MARK: - Actions

	func fetchRequest(country: String)
}

class FetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository

	// MARK: - Inits

	init(topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository) {
		self.topHeadlinesQueriesRepository = topHeadlinesQueriesRepository
	}

	// MARK: - Actions

	func fetchRequest(country: String) {
		topHeadlinesQueriesRepository
			.fetchRequest(country: country)
	}
}
