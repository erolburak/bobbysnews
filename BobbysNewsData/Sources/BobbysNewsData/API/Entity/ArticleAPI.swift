//
//  ArticleAPI.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

public struct ArticleAPI: Decodable, Sendable {
    // MARK: - Private Type Definitions

    private enum CodingKeys: String, CodingKey {
        case content, image, publishedAt, source, title, url
        case story = "description"
    }

    // MARK: - Properties

    public let content: String?
    public let image: URL?
    public let publishedAt: Date?
    public let source: SourceAPI?
    public let story: String?
    public let title: String?
    public let url: URL?
}
