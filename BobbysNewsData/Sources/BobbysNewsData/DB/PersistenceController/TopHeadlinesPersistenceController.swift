//
//  TopHeadlinesPersistenceController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 03.09.23.
//

import CoreData

public protocol PTopHeadlinesPersistenceController: Sendable {
    // MARK: - Methods

    func delete() throws
    func read(country: String) throws -> [ArticleDB]
    func save(country: String,
              topHeadlinesAPI: TopHeadlinesAPI) throws
}

final class TopHeadlinesPersistenceController: PTopHeadlinesPersistenceController {
    // MARK: - Methods

    func delete() throws {
        try PersistenceController.shared.backgroundContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "ArticleDB")))
        try PersistenceController.shared.backgroundContext.save()
    }

    func read(country: String) throws -> [ArticleDB] {
        try PersistenceController.shared.backgroundContext.performAndWait {
            let fetchRequest = ArticleDB.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ArticleDB.publishedAt,
                                                             ascending: false)]
            fetchRequest.predicate = NSPredicate(format: "country == %@",
                                                 country)
            return try PersistenceController.shared.backgroundContext.fetch(fetchRequest)
        }
    }

    func save(country: String,
              topHeadlinesAPI: TopHeadlinesAPI) throws
    {
        try PersistenceController.shared.backgroundContext.performAndWait {
            let existingArticles = try PersistenceController.shared.backgroundContext.fetch(ArticleDB.fetchRequest())
            topHeadlinesAPI.articles?.forEach { articleAPI in
                guard articleAPI.title?.localizedCaseInsensitiveContains("[removed]") == false,
                      articleAPI.content?.localizedCaseInsensitiveContains("[removed]") == false
                else {
                    return
                }
                let existingArticle = existingArticles.first { $0.title == articleAPI.title }
                if existingArticle != nil {
                    /// Update existing article
                    existingArticle?.author = articleAPI.author
                    existingArticle?.content = articleAPI.content
                    existingArticle?.country = country
                    existingArticle?.publishedAt = articleAPI.publishedAt
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
    }
}
