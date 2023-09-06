//
//  SaveTopHeadlinesSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import Combine

protocol PSaveTopHeadlinesSourcesUseCase {

	// MARK: - Actions

	func saveSources(sourcesDto: SourcesDTO)
}

class SaveTopHeadlinesSourcesUseCase: PSaveTopHeadlinesSourcesUseCase {

	// MARK: - Private Properties

	private let topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository

	// MARK: - Life Cycle

	init(topHeadlinesQueriesRepository: PTopHeadlinesQueriesRepository) {
		self.topHeadlinesQueriesRepository = topHeadlinesQueriesRepository
	}

	// MARK: - Actions

	func saveSources(sourcesDto: SourcesDTO) {
		topHeadlinesQueriesRepository
			.saveSources(sourcesDto: sourcesDto)
	}
}
