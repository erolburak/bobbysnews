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

	var queriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(EntityMock.topHeadlinesEntity)

	// MARK: - Actions

	func delete(country: String?) throws {
		queriesSubject.send(nil)
	}

	func fetchRequest(country: String) {
		queriesSubject.send(TopHeadlines(articles: EntityMock.topHeadlinesEntity?.articles?.filter { $0.country == country },
										 status: EntityMock.topHeadlinesEntity?.status,
										 totalResults: EntityMock.topHeadlinesEntity?.totalResults))
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: String,
			  topHeadlinesApi: TopHeadlinesApi) {
		var articles: [Article] = []
		topHeadlinesApi.articles?.forEach { articleApi in
			guard queriesSubject.value?.articles?.filter({ $0.title == articleApi.title }).isEmpty == true,
				  articleApi.title?.isEmpty == false else {
				return
			}
			articles.append(Article(author: articleApi.author,
									content: articleApi.content,
									country: country,
									publishedAt: articleApi.publishedAt?.toDate,
									source: Source(category: articleApi.source?.category,
												   country: articleApi.source?.country,
												   id: articleApi.source?.id,
												   language: articleApi.source?.language,
												   name: articleApi.source?.name,
												   story: articleApi.source?.story,
												   url: articleApi.source?.url),
									story: articleApi.story,
									title: articleApi.title,
									url: articleApi.url,
									urlToImage: articleApi.urlToImage))
		}
		queriesSubject.send(TopHeadlines(articles: articles + (EntityMock.topHeadlinesEntity?.articles ?? []),
										 status: topHeadlinesApi.status,
										 totalResults: (topHeadlinesApi.totalResults ?? 0) + (EntityMock.topHeadlinesEntity?.totalResults ?? 0)))
	}
}
