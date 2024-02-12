//
//  SourcesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

@preconcurrency
import Combine

public final class SourcesPersistenceControllerMock: PSourcesPersistenceController {

	// MARK: - Properties

	public let queriesSubject: CurrentValueSubject<[SourceDB]?, Never> = CurrentValueSubject(EntityMock.sourcesDB)

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
