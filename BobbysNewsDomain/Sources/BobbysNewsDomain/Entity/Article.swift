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
    public let category: String?
    public let content: String?
    public let country: String?
    public let image: URL?
    public let publishedAt: Date?
    public let source: Source?
    public let story: String?
    public let title: String?
    public let url: URL?
    public var contentTranslated: String?
    public var showTranslations = false
    public var titleTranslated: String?

    // MARK: - Lifecycles

    public init(
        category: String?,
        content: String?,
        country: String?,
        image: URL?,
        publishedAt: Date?,
        source: Source?,
        story: String?,
        title: String?,
        url: URL?
    ) {
        self.category = category
        self.content = content
        self.country = country
        self.image = image
        self.publishedAt = publishedAt
        self.source = source
        self.story = story
        self.title = title
        self.url = url
    }
}
