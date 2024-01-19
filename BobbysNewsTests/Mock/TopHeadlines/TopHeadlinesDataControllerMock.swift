//
//  TopHeadlinesDataControllerMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 04.09.23.
//

@testable import BobbysNews
import Combine

class TopHeadlinesDataControllerMock: PTopHeadlinesDataController {

	// MARK: - Properties

	var queriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(EntityMock.topHeadlines1)

	// MARK: - Actions

	func delete(country: String?) throws {
		queriesSubject.send(nil)
	}

	func fetchRequest(country: String) {
		queriesSubject.send(TopHeadlines(articles: EntityMock.topHeadlines1.articles?.filter { $0.country == country },
										 status: EntityMock.topHeadlines1.status,
										 totalResults: EntityMock.topHeadlines1.totalResults))
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: String,
			  topHeadlinesDto: TopHeadlinesDTO) {
		var articles: [Article] = []
		topHeadlinesDto.articles?.forEach { articleDto in
			guard queriesSubject.value?.articles?.filter({ $0.title == articleDto.title }).isEmpty == true,
				  articleDto.title?.isEmpty == false,
				  let article = articleDto.toDomain(country: country) else {
				return
			}
			articles.append(article)
		}
		queriesSubject.send(TopHeadlines(articles: articles + (EntityMock.topHeadlines1.articles ?? []),
										 status: topHeadlinesDto.status,
										 totalResults: (topHeadlinesDto.totalResults ?? 0) + (EntityMock.topHeadlines1.totalResults ?? 0)))
	}
}
