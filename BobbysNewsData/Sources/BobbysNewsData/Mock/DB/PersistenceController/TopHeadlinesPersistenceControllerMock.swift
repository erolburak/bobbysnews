//
//  TopHeadlinesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

import Combine

public final class TopHeadlinesPersistenceControllerMock: PTopHeadlinesPersistenceController {

	// MARK: - Private Properties

	private let entity = EntityMock()

	// MARK: - Properties

	public lazy var queriesSubject: CurrentValueSubject<[ArticleDB]?, Never> = CurrentValueSubject(entity.topHeadlinesDB)

	// MARK: - Actions

	public func delete() throws {
		queriesSubject.send(nil)
	}

	public func fetchRequest(country: String) {
		queriesSubject.send(entity.topHeadlinesDB.filter { $0.country == country })
	}

	public func read() -> AnyPublisher<[ArticleDB], Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	public func save(country: String,
					 topHeadlinesAPI: TopHeadlinesAPI) {
		queriesSubject.send((topHeadlinesAPI.articles?.compactMap { articleAPI in
			ArticleDB(from: articleAPI,
					  country: country)
		} ?? []) + entity.topHeadlinesDB)
	}
}
