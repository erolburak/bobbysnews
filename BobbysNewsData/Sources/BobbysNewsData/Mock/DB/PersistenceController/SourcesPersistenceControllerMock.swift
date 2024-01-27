//
//  SourcesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

import Combine

public class SourcesPersistenceControllerMock: PSourcesPersistenceController {

	// MARK: - Properties

	public var queriesSubject: CurrentValueSubject<[SourceDB]?, Never> = CurrentValueSubject(EntityMock.sourcesDB)

	// MARK: - Inits

	public init() {}

	// MARK: - Actions

	public func delete() throws {
		queriesSubject.send(nil)
	}

	public func fetchRequest() {
		queriesSubject.send(EntityMock.sourcesDB)
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
		} ?? []) + EntityMock.sourcesDB)
	}
}
