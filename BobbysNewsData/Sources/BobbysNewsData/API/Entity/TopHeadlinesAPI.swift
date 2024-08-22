//
//  TopHeadlinesAPI.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

public struct TopHeadlinesAPI: Decodable, Sendable {
    // MARK: - Properties

    public let articles: [ArticleAPI]?
}
