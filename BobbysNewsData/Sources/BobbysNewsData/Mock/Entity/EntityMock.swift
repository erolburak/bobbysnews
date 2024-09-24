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
    static let articleAPI = ArticleAPI(author: "Test",
                                       content: "Test",
                                       publishedAt: .distantPast,
                                       source: sourceAPI,
                                       story: "Test",
                                       title: "Test",
                                       url: URL(string: "Test"),
                                       urlToImage: URL(string: "Test"))
    static let sourceAPI = SourceAPI(category: "Test",
                                     country: "uk",
                                     id: "Test",
                                     language: "Test",
                                     name: "Test",
                                     story: "Test",
                                     url: URL(string: "Test"))
    static let sourcesAPI = SourcesAPI(sources: [sourceAPI])
    static let topHeadlinesAPI = TopHeadlinesAPI(articles: [articleAPI])

    /// Mocks which represent DB entities
    lazy var sourcesDB = {
        let sourceDB = SourceDB(context: PersistenceController.shared.backgroundContext)
        sourceDB.category = "Test"
        sourceDB.country = "uk"
        sourceDB.id = "Test"
        sourceDB.language = "Test"
        sourceDB.name = "Test"
        sourceDB.story = "Test"
        sourceDB.url = URL(string: "Test")
        return [sourceDB]
    }()

    lazy var topHeadlinesDB = {
        let articleDB = ArticleDB(context: PersistenceController.shared.backgroundContext)
        articleDB.author = "Test"
        articleDB.content = "Test"
        articleDB.country = "uk"
        articleDB.publishedAt = .distantPast
        articleDB.source = sourcesDB.first
        articleDB.story = "Test"
        articleDB.title = "Test"
        articleDB.url = URL(string: "Test")
        articleDB.urlToImage = URL(string: "Test")
        return [articleDB]
    }()
}
