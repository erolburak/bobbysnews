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

    static let article = Article(
        category: "Category",
        content: "ContentStart\n\n\n\n\n\n\nContentEnd",
        country: "Country",
        image: URL(
            string:
                "https://erolburak.com/images/burakerol.png"
        ),
        publishedAt: .now,
        source: Source(
            name: "SourceName",
            url: URL(string: "https://github.com/erolburak/bobbysnews")),
        story: "Story",
        title: "Title",
        url: URL(string: "https://github.com/erolburak/bobbysnews")
    )
}
