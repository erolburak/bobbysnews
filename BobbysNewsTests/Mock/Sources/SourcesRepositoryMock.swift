//
//  SourcesRepositoryMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNews
import Combine

class SourcesRepositoryMock: PSourcesRepository {

	// MARK: - Actions

	func fetch(apiKey: String) -> AnyPublisher<SourcesDTO, Error> {
		Just(DTOMock.sourcesDto1)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
}
