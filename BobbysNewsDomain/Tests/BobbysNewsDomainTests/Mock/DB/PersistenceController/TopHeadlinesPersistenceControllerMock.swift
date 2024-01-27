//
//  TopHeadlinesPersistenceControllerMock.swift
//	BobbysNewsDomain
//
//  Created by Burak Erol on 25.01.24.
//

import BobbysNewsData
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
			  topHeadlines: [ArticleDB]) {
		queriesSubject.send(topHeadlines + EntityMock.topHeadlinesDB)
	}
}
