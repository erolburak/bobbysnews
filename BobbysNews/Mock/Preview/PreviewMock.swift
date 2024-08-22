//
//  PreviewMock.swift
//  BobbysNews
//
//  Created by Burak Erol on 12.08.24.
//

import BobbysNewsDomain
import Foundation

enum PreviewMock {
    // MARK: - Properties

    static let article = Article(author: "Author",
                                 content: "ContentStart\n\n\n\n\n\n\n\n\n\n\n\n\n\nContentEnd",
                                 country: "Country",
                                 publishedAt: .now,
                                 source: Source(category: "SourceCategory",
                                                country: "SourceCountry",
                                                id: "SourceId",
                                                language: "SourceLanguage",
                                                name: "SourceName",
                                                story: "SourceStory",
                                                url: URL(string: "https://github.com/erolburak/bobbysnews")),
                                 story: "Story",
                                 title: "Title",
                                 url: URL(string: "https://github.com/erolburak/bobbysnews"),
                                 urlToImage: URL(string: "https://raw.githubusercontent.com/erolburak/bobbysnews/main/BobbysNews/Resource/Assets.xcassets/AppIcon.appiconset/%E2%80%8EAppIcon.png"))
}
