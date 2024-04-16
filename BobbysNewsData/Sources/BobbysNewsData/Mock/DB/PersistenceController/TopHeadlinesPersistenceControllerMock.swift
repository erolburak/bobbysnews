//
//  TopHeadlinesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

import Combine

public final class TopHeadlinesPersistenceControllerMock: PTopHeadlinesPersistenceController {

	// MARK: - Properties

	public let queriesSubject: CurrentValueSubject<[ArticleDB]?, Never> = CurrentValueSubject(EntityMock.topHeadlinesDB)

	// MARK: - Actions

	public func delete() throws {
		queriesSubject.send(nil)
	}

	public func fetchRequest(country: String) {
		queriesSubject.send(EntityMock.topHeadlinesDB.filter { $0.country == country })
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
		} ?? []) + EntityMock.topHeadlinesDB)
	}
}
