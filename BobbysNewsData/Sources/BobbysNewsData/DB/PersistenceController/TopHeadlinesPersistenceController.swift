//
//  TopHeadlinesPersistenceController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 03.09.23.
//

import Combine
import CoreData

public protocol PTopHeadlinesPersistenceController {

	// MARK: - Properties

	var queriesSubject: CurrentValueSubject<[ArticleDB]?, Never> { get }

	// MARK: - Actions

	func delete(country: String?) throws
	func fetchRequest(country: String)
	func read() -> AnyPublisher<[ArticleDB], Error>
	func save(country: String,
			  topHeadlinesAPI: TopHeadlinesAPI)
}

final class TopHeadlinesPersistenceController: PTopHeadlinesPersistenceController {

	// MARK: - Properties

	static let shared = TopHeadlinesPersistenceController()

	// MARK: - Private Properties

	internal let queriesSubject: CurrentValueSubject<[ArticleDB]?, Never> = CurrentValueSubject(nil)

	// MARK: - Actions

	func delete(country: String?) throws {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleDB")
		if let country {
			fetchRequest.predicate = NSPredicate(format: "country == %@", country)
		}
		try PersistenceController.shared.backgroundContext.execute(NSBatchDeleteRequest(fetchRequest: fetchRequest))
		try PersistenceController.shared.backgroundContext.save()
		queriesSubject.send(nil)
	}

	func fetchRequest(country: String) {
		do {
			try PersistenceController.shared.backgroundContext.performAndWait {
				let fetchRequest = ArticleDB.fetchRequest()
				fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ArticleDB.publishedAt,
																 ascending: false)]
				fetchRequest.predicate = NSPredicate(format: "country == %@", country)
				queriesSubject.send(try PersistenceController.shared.backgroundContext.fetch(fetchRequest))
			}
		} catch {
			queriesSubject.send(nil)
		}
	}

	func read() -> AnyPublisher<[ArticleDB], Error> {
		queriesSubject
			.compactMap { $0 }
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}

	func save(country: String,
			  topHeadlinesAPI: TopHeadlinesAPI) {
		do {
			try PersistenceController.shared.backgroundContext.performAndWait {
				let existingArticles = try PersistenceController.shared.backgroundContext.fetch(ArticleDB.fetchRequest())
				topHeadlinesAPI.articles?.forEach { articleAPI in
					guard articleAPI.title?.isEmpty == false else {
						return
					}
					let existingArticle = existingArticles.first { $0.title == articleAPI.title }
					if existingArticle != nil {
						/// Update existing article
						existingArticle?.author = articleAPI.author
						existingArticle?.content = articleAPI.content
						existingArticle?.country = country
						existingArticle?.publishedAt = articleAPI.publishedAt?.toDate
						existingArticle?.source?.category = articleAPI.source?.category
						existingArticle?.source?.country = articleAPI.source?.country
						existingArticle?.source?.id = articleAPI.source?.id
						existingArticle?.source?.language = articleAPI.source?.language
						existingArticle?.source?.name = articleAPI.source?.name
						existingArticle?.source?.story = articleAPI.source?.story
						existingArticle?.source?.url = articleAPI.source?.url
						existingArticle?.story = articleAPI.story
						existingArticle?.title = articleAPI.title
						existingArticle?.url = articleAPI.url
						existingArticle?.urlToImage = articleAPI.urlToImage
					} else {
						/// Create new article
						ArticleDB(from: articleAPI,
								  country: country)
					}
				}
				try PersistenceController.shared.backgroundContext.save()
			}
			fetchRequest(country: country)
		} catch {
			queriesSubject.send(nil)
		}
	}
}
