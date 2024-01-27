//
//  SourcesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@testable import BobbysNewsData
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

	func save(sourcesAPI: SourcesAPI) {
		queriesSubject.send((sourcesAPI.sources?.compactMap { sourceAPI in
			SourceDB(from: sourceAPI)
		} ?? []) + EntityMock.sourcesDB)
	}
}
