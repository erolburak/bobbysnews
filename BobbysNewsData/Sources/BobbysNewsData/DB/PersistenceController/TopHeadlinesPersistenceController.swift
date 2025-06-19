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
    func read(
        category: String,
        country: String
    ) throws -> [ArticleDB]
    func save(
        category: String,
        country: String,
        topHeadlinesAPI: TopHeadlinesAPI
    ) throws
}

final class TopHeadlinesPersistenceController: PTopHeadlinesPersistenceController {
    // MARK: - Methods

    func delete() throws {
        try PersistenceController.shared.backgroundContext.execute(
            NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "ArticleDB"))
        )
        try PersistenceController.shared.backgroundContext.save()
    }

    func read(
        category: String,
        country: String
    ) throws -> [ArticleDB] {
        try PersistenceController.shared.backgroundContext.performAndWait {
            let fetchRequest = ArticleDB.fetchRequest()
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(
                    keyPath: \ArticleDB.publishedAt,
                    ascending: false
                )
            ]
            fetchRequest.predicate = NSCompoundPredicate(
                type: .and,
                subpredicates: [
                    NSPredicate(
                        format: "category = %@",
                        category),
                    NSPredicate(
                        format: "country = %@",
                        country),
                ]
            )
            return try PersistenceController.shared.backgroundContext.fetch(fetchRequest)
        }
    }

    func save(
        category: String,
        country: String,
        topHeadlinesAPI: TopHeadlinesAPI
    ) throws {
        try PersistenceController.shared.backgroundContext.performAndWait {
            let existingArticles = try PersistenceController.shared.backgroundContext.fetch(
                ArticleDB.fetchRequest())
            topHeadlinesAPI.articles?.forEach {
                let existingArticle = existingArticles.first { $0.title == $0.title }
                if existingArticle != nil {
                    /// Update existing article
                    existingArticle?.category = category
                    existingArticle?.content = $0.content
                    existingArticle?.country = country
                    existingArticle?.image = $0.image
                    existingArticle?.publishedAt = $0.publishedAt
                    existingArticle?.source?.name = $0.source?.name
                    existingArticle?.source?.url = $0.source?.url
                    existingArticle?.story = $0.story
                    existingArticle?.title = $0.title
                    existingArticle?.url = $0.url
                } else {
                    /// Create new article
                    ArticleDB(
                        from: $0,
                        category: category,
                        country: country
                    )
                }
            }
            try PersistenceController.shared.backgroundContext.save()
        }
    }
}
