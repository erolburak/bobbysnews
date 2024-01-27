//
//  SourcesPersistenceControllerMock.swift
//	BobbysNewsDomain
//
//  Created by Burak Erol on 25.01.24.
//

import BobbysNewsData
import Combine

class SourcesPersistenceControllerMock: PSourcesPersistenceController {

	// MARK: - Properties

	var queriesSubject: CurrentValueSubject<[SourceDB]?, Never> = CurrentValueSubject(EntityMock.sourcesDB)

	// MARK: - Actions

	func delete() throws {
		queriesSubject.send(nil)
	}

	func fetchRequest() {
		queriesSubject.send(EntityMock.sourcesDB)
	}

	func read() -> AnyPublisher<[SourceDB], Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(sources: [SourceDB]) {
		queriesSubject.send(sources + EntityMock.sourcesDB)
	}
}
