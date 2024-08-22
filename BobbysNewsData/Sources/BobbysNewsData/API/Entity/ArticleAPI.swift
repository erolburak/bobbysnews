//
//  ArticleAPI.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

public struct ArticleAPI: Decodable, Sendable {
    // MARK: - Type Definitions

    private enum CodingKeys: String, CodingKey {
        case author, content, publishedAt, source, title, url, urlToImage
        case story = "description"
    }

    // MARK: - Properties

    public let author: String?
    public let content: String?
    public let publishedAt: Date?
    public let source: SourceAPI?
    public let story: String?
    public let title: String?
    public let url: URL?
    public let urlToImage: URL?
}
