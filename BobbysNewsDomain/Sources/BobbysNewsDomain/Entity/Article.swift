//
//  Article.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 01.09.23.
//

import Foundation

public struct Article: Hashable, Identifiable, Sendable {
    // MARK: - Properties

    public let id = UUID()
    public let author: String?
    public let content: String?
    public let country: String?
    public let publishedAt: Date?
    public let source: Source?
    public let story: String?
    public let title: String?
    public let url: URL?
    public let urlToImage: URL?
    public var contentTranslated: String?
    public var titleTranslated: String?

    // MARK: - Lifecycles

    public init(author: String?,
                content: String?,
                country: String?,
                publishedAt: Date?,
                source: Source?,
                story: String?,
                title: String?,
                url: URL?,
                urlToImage: URL?)
    {
        self.author = author
        self.content = content
        self.country = country
        self.publishedAt = publishedAt
        self.source = source
        self.story = story
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
    }
}
