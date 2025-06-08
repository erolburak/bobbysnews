//
//  EntityMock.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

import BobbysNewsData
import BobbysNewsDomain
import Foundation

struct EntityMock {
    // MARK: - Properties

    /// Mocks which represent Domain entities
    static let categories = Categories.allCases
    static let errors: [Errors] = [.custom("Test",
                                           "Test"),
                                   .error("Test"),
                                   .fetchTopHeadlines,
                                   .noNetworkConnection,
                                   .read,
                                   .reset]
    static let topHeadlines = TopHeadlines(articles: [Article(category: "Test",
                                                              content: "Test",
                                                              country: "Test",
                                                              image: URL(string: "Test"),
                                                              publishedAt: .distantPast,
                                                              source: Source(name: "Test",
                                                                             url: URL(string: "Test")),
                                                              story: "Test",
                                                              title: "Test",
                                                              url: URL(string: "Test"))])

    /// Mocks which represent DB entities
    lazy var articleDB = {
        let articleDB = ArticleDB(context: PersistenceController.shared.backgroundContext)
        articleDB.category = "Test"
        articleDB.content = "Test"
        articleDB.country = "Test"
        articleDB.image = URL(string: "Test")
        articleDB.publishedAt = .distantPast
        articleDB.source = sourceDB
        articleDB.story = "Test"
        articleDB.title = "Test"
        articleDB.url = URL(string: "Test")
        return articleDB
    }()

    lazy var sourceDB = {
        let sourceDB = SourceDB(context: PersistenceController.shared.backgroundContext)
        sourceDB.name = "Test"
        sourceDB.url = URL(string: "Test")
        return sourceDB
    }()
}
