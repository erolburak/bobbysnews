//
//  EntityMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 26.01.24.
//

import BobbysNewsDomain
import Foundation

enum EntityMock {
    // MARK: - Private Properties

    private static let source = Source(category: "Test",
                                       country: "en-gb",
                                       id: "Test",
                                       language: "Test",
                                       name: "Test",
                                       story: "Test",
                                       url: URL(string: "Test"))

    // MARK: - Properties

    static let article = Article(author: "Test",
                                 content: "Test",
                                 country: "en-gb",
                                 publishedAt: .now,
                                 source: source,
                                 story: "Test",
                                 title: "Test",
                                 url: URL(string: "Test"),
                                 urlToImage: URL(string: "Test"))
    static let errors: [Errors] = [.error(String(localized: "ErrorDescription")),
                                   .fetchSources,
                                   .fetchTopHeadlines,
                                   .invalidApiKey,
                                   .limitedRequests,
                                   .read,
                                   .reset]
    static let sources = Sources(sources: [source])
    static let topHeadlines = TopHeadlines(articles: [article])
}
