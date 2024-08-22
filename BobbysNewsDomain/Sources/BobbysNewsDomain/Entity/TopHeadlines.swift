//
//  TopHeadlines.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 01.09.23.
//

public struct TopHeadlines: Sendable {
    // MARK: - Properties

    public let articles: [Article]?

    // MARK: - Lifecycles

    public init(articles: [Article]?) {
        self.articles = articles
    }
}
