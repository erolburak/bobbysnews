//
//  SaveSourcesUseCase.swift
//  BobbysNews
//
//  Created by Burak Erol on 05.09.23.
//

import Combine

protocol PSaveSourcesUseCase {

	// MARK: - Actions

	func save(sourcesDto: SourcesDTO)
}

class SaveSourcesUseCase: PSaveSourcesUseCase {

	// MARK: - Private Properties

	private let sourcesQueriesRepository: PSourcesQueriesRepository

	// MARK: - Life Cycle

	init(sourcesQueriesRepository: PSourcesQueriesRepository) {
		self.sourcesQueriesRepository = sourcesQueriesRepository
	}

	// MARK: - Actions

	func save(sourcesDto: SourcesDTO) {
		sourcesQueriesRepository
			.save(sourcesDto: sourcesDto)
	}
}
