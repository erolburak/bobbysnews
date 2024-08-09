//
//  EntityMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 26.01.24.
//

import BobbysNewsDomain
import Foundation

struct EntityMock {

	// MARK: - Private Properties

	private lazy var source = Source(category: "Test",
									 country: "Test",
									 id: "Test",
									 language: "Test",
									 name: "Test",
									 story: "Test",
									 url: URL(string: "Test"))

	// MARK: - Properties

	lazy var article = Article(author: "Test",
							   content: "Test",
							   country: "us",
							   publishedAt: .now,
							   source: source,
							   story: "Test",
							   title: "Test",
							   url: URL(string: "Test"),
							   urlToImage: URL(string: "Test"))
	lazy var errors: [Errors] = [.error(String(localized: "ErrorDescription")),
								 .fetchSources,
								 .fetchTopHeadlines,
								 .invalidApiKey,
								 .limitedRequests,
								 .read,
								 .reset]
	lazy var sources = Sources(sources: [source])
	lazy var topHeadlines = TopHeadlines(articles: [article])
}
