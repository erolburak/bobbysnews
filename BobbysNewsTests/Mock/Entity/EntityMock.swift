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

    private static let source = Source(
        name: "Test",
        url: URL(string: "Test")
    )

    // MARK: - Properties

    static let article = Article(
        category: "Test",
        content: "Test",
        country: "Test",
        image: URL(string: "Test"),
        publishedAt: .now,
        source: source,
        story: "Test",
        title: "Test",
        url: URL(string: "Test")
    )
    static let errors: [Errors] = [
        .custom(
            "Test",
            "Test"),
        .error("Test"),
        .fetchTopHeadlines,
        .noNetworkConnection,
        .read,
        .reset,
    ]
    static let topHeadlines = TopHeadlines(articles: [article])
}
