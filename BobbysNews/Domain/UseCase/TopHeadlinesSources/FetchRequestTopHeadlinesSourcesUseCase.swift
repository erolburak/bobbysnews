//
//  FetchRequestTopHeadlinesSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import Combine

protocol PFetchRequestTopHeadlinesSourcesUseCase {
	func fetchSourcesRequest()
}

class FetchRequestTopHeadlinesSourcesUseCase: PFetchRequestTopHeadlinesSourcesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository

	// MARK: - Life Cycle

	init(topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository) {
		self.topHeadlinesQueriesRepository = topHeadlinesQueriesRepository
	}

	// MARK: - Actions

	func fetchSourcesRequest() {
		topHeadlinesQueriesRepository
			.fetchSourcesRequest()
	}
}
