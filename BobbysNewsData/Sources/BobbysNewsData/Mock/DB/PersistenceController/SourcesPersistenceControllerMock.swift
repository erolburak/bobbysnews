//
//  SourcesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

import Combine

public final class SourcesPersistenceControllerMock: PSourcesPersistenceController {

	// MARK: - Private Properties

	private let entity = EntityMock()

	// MARK: - Properties

	public lazy var queriesSubject: CurrentValueSubject<[SourceDB]?, Never> = CurrentValueSubject(entity.sourcesDB)

	// MARK: - Actions

	public func delete() throws {
		queriesSubject.send(nil)
	}

	public func fetchRequest() {
		queriesSubject.send(entity.sourcesDB)
	}

	public func read() -> AnyPublisher<[SourceDB], Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	public func save(sourcesAPI: SourcesAPI) {
		queriesSubject.send((sourcesAPI.sources?.compactMap { sourceAPI in
			SourceDB(from: sourceAPI)
		} ?? []) + entity.sourcesDB)
	}
}
