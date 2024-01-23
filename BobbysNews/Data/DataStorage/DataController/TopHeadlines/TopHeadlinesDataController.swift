//
//  TopHeadlinesDataController.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import Combine
import CoreData

protocol PTopHeadlinesDataController {

	// MARK: - Properties

	var queriesSubject: CurrentValueSubject<TopHeadlines?, Never> { get }

	// MARK: - Actions

	func delete(country: String?) throws
	func fetchRequest(country: String)
	func read() -> AnyPublisher<TopHeadlines, Error>
	func save(country: String,
			  topHeadlinesApi: TopHeadlinesApi)
}

class TopHeadlinesDataController: PTopHeadlinesDataController {

	// MARK: - Properties

	static let shared = TopHeadlinesDataController()

	// MARK: - Private Properties

	internal let queriesSubject: CurrentValueSubject<TopHeadlines?, Never> = CurrentValueSubject(nil)
	private let backgroundContext = DataController.shared.backgroundContext

	// MARK: - Actions

	func delete(country: String?) throws {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
		if let country {
			fetchRequest.predicate = NSPredicate(format: "country == %@", country)
		}
		try backgroundContext.execute(NSBatchDeleteRequest(fetchRequest: fetchRequest))
		try backgroundContext.save()
		queriesSubject.send(nil)
	}

	func fetchRequest(country: String) {
		backgroundContext.performAndWait {
			do {
				let fetchRequest = ArticleEntity.fetchRequest()
				fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ArticleEntity.publishedAt,
																 ascending: false)]
				fetchRequest.predicate = NSPredicate(format: "country == %@", country)
				let result = try backgroundContext.fetch(fetchRequest)
				let topHeadlines = TopHeadlines(articles: result.compactMap { Article(from: $0) },
												status: nil,
												totalResults: result.count)
				queriesSubject.send(topHeadlines)
			} catch {
				queriesSubject.send(nil)
			}
		}
	}

	func read() -> AnyPublisher<TopHeadlines, Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: String,
			  topHeadlinesApi: TopHeadlinesApi) {
		backgroundContext.performAndWait {
			do {
				try topHeadlinesApi.articles?.forEach { articleApi in
					guard articleApi.title?.isEmpty == false else {
						return
					}
					let articles = try backgroundContext.fetch(ArticleEntity.fetchRequest())
					let article = articles.filter { $0.title == articleApi.title }.first
					if article == nil {
						/// Create article if not existing
						ArticleEntity(from: articleApi,
									  country: country,
									  in: backgroundContext)
					} else {
						/// Update article if existing
						article?.author = articleApi.author
						article?.content = articleApi.content
						article?.country = country
						article?.publishedAt = articleApi.publishedAt?.toDate
						article?.source?.category = articleApi.source?.category
						article?.source?.country = articleApi.source?.country
						article?.source?.id = articleApi.source?.id
						article?.source?.language = articleApi.source?.language
						article?.source?.name = articleApi.source?.name
						article?.source?.story = articleApi.source?.story
						article?.source?.url = articleApi.source?.url
						article?.story = articleApi.story
						article?.title = articleApi.title
						article?.url = articleApi.url
						article?.urlToImage = articleApi.urlToImage
					}
				}
				try backgroundContext.save()
			} catch {
				queriesSubject.send(nil)
			}
		}
		fetchRequest(country: country)
	}
}
