//
//  TopHeadlinesPersistenceControllerMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNewsData
import Combine

class TopHeadlinesPersistenceControllerMock: PTopHeadlinesPersistenceController {

	// MARK: - Properties

	var queriesSubject: CurrentValueSubject<[ArticleDB]?, Never> = CurrentValueSubject(EntityMock.topHeadlinesDB)

	// MARK: - Actions

	func delete(country: String?) throws {
		queriesSubject.send(nil)
	}

	func fetchRequest(country: String) {
		queriesSubject.send(EntityMock.topHeadlinesDB.filter { $0.country == country })
	}

	func read() -> AnyPublisher<[ArticleDB], Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: String,
			  topHeadlinesAPI: TopHeadlinesAPI) {
		queriesSubject.send((topHeadlinesAPI.articles?.compactMap { articleAPI in
			ArticleDB(from: articleAPI,
					  country: country)
		} ?? []) + EntityMock.topHeadlinesDB)
	}
}
