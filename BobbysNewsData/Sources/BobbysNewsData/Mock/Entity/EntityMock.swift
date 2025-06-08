//
//  EntityMock.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 06.09.23.
//

import Foundation

struct EntityMock {
    // MARK: - Properties

    /// Mocks which represent API entities
    static let articleAPI = ArticleAPI(content: "Test",
                                       image: URL(string: "Test"),
                                       publishedAt: .distantPast,
                                       source: sourceAPI,
                                       story: "Test",
                                       title: "Test",
                                       url: URL(string: "Test"))
    static let errorsAPI: [ErrorsAPI] = [.badRequest,
                                         .forbidden,
                                         .internalServerError,
                                         .serviceUnavailable,
                                         .tooManyRequests,
                                         .unauthorized]
    static let sourceAPI = SourceAPI(name: "Test",
                                     url: URL(string: "Test"))
    static let topHeadlinesAPI = TopHeadlinesAPI(articles: [articleAPI])

    /// Mocks which represent DB entities
    lazy var topHeadlinesDB = {
        let articleDB = ArticleDB(context: PersistenceController.shared.backgroundContext)
        articleDB.category = "Test"
        articleDB.content = "Test"
        articleDB.country = "Test"
        articleDB.image = URL(string: "Test")
        articleDB.publishedAt = .distantPast
        let sourceDB = SourceDB(context: PersistenceController.shared.backgroundContext)
        sourceDB.name = "Test"
        sourceDB.url = URL(string: "Test")
        articleDB.source = sourceDB
        articleDB.story = "Test"
        articleDB.title = "Test"
        articleDB.url = URL(string: "Test")
        return [articleDB]
    }()
}
