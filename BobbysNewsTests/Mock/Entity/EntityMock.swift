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

	private static let source1 = Source(category: "Test 1",
										country: "Test 1",
										id: "Test 1",
										language: "Test 1",
										name: "Test 1",
										story: "Test 1",
										url: URL(string: "Test 1"))
	private static let source2 = Source(category: "Test 2",
										country: "Test 2",
										id: "Test 2",
										language: "Test 2",
										name: "Test 2",
										story: "Test 2",
										url: URL(string: "Test 2"))
	
	// MARK: - Properties
	
	static let article1 = Article(author: "Test 1",
								  content: "Test 1",
								  country: "Test 1",
								  publishedAt: .now,
								  source: source1,
								  story: "Test 1",
								  title: "Test 1",
								  url: URL(string: "Test 1"),
								  urlToImage: URL(string: "Test 1"))
	static let article2 = Article(author: "Test 2",
								  content: "Test 2",
								  country: "Test 2",
								  publishedAt: .now,
								  source: source2,
								  story: "Test 2",
								  title: "Test 2",
								  url: URL(string: "Test 2"),
								  urlToImage: URL(string: "Test 2"))
	static let errors: [Errors] = [.error(String(localized: "ErrorDescription")),
								   .fetchSources,
								   .fetchTopHeadlines,
								   .invalidApiKey,
								   .limitedRequests,
								   .read,
								   .reset]
	static let sources = Sources(sources: [source1,
										   source2])
	static let topHeadlines = TopHeadlines(articles: [article1,
													  article2])
}
