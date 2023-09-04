//
//  SaveTopHeadlinesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine

protocol PSaveTopHeadlinesUseCase {
	func save(country: Country,
			  topHeadlinesDto: TopHeadlinesDTO)
}

class SaveTopHeadlinesUseCase: PSaveTopHeadlinesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository

	// MARK: - Life Cycle

	init(topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository) {
		self.topHeadlinesQueriesRepository = topHeadlinesQueriesRepository
	}

	// MARK: - Actions

	func save(country: Country,
			  topHeadlinesDto: TopHeadlinesDTO) {
		topHeadlinesQueriesRepository
			.save(country: country,
				  topHeadlinesDto: topHeadlinesDto)
	}
}
