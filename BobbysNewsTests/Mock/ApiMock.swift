//
//  ApiMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 06.09.23.
//

@testable import BobbysNews
import Foundation

struct ApiMock {

	// MARK: - Properties

	/// Mocks which represent existing ones
	static let articleApi1 = ArticleApi(author: "Test 1",
										content: "Test 1",
										publishedAt: "2001-02-03T12:34:56Z",
										source: sourceApi1,
										story: "Test 1",
										title: "Test 1",
										url: URL(string: "Test 1"),
										urlToImage: URL(string: "Test 1"))
	static let articleApi2 = ArticleApi(author: "Test 2",
										content: "Test 2",
										publishedAt: "2001-02-03T12:34:56Z",
										source: sourceApi2,
										story: "Test 2",
										title: "Test 2",
										url: URL(string: "Test 2"),
										urlToImage: URL(string: "Test 2"))
	static let sourceApi1 = SourceApi(category: "Test 1",
									  country: "Test 1",
									  id: "Test 1",
									  language: "Test 1",
									  name: "Test 1",
									  story: "Test 1",
									  url: URL(string: "Test 1"))
	static let sourceApi2 = SourceApi(category: "Test 2",
									  country: "Test 2",
									  id: "Test 2",
									  language: "Test 2",
									  name: "Test 2",
									  story: "Test 2",
									  url: URL(string: "Test 2"))
	static let sourcesApi1 = SourcesApi(sources: [sourceApi1,
												  sourceApi2],
										status: "Test 1")
	static let topHeadlinesApi1 = TopHeadlinesApi(articles: [articleApi1,
															 articleApi2],
												  status: "Test 1",
												  totalResults: 2)

	/// Mocks which represent new ones
	static let articleApi3 = ArticleApi(author: "Test 3",
										content: "Test 3",
										publishedAt: "2001-02-03T12:34:56Z",
										source: sourceApi3,
										story: "Test 3",
										title: "Test 3",
										url: URL(string: "Test 3"),
										urlToImage: URL(string: "Test 3"))
	static let articleApi4 = ArticleApi(author: "Test 4",
										content: "Test 4",
										publishedAt: "2001-02-03T12:34:56Z",
										source: sourceApi4,
										story: "Test 4",
										title: "Test 4",
										url: URL(string: "Test 4"),
										urlToImage: URL(string: "Test 4"))
	static let sourceApi3 = SourceApi(category: "Test 3",
									  country: "Test 3",
									  id: "Test 3",
									  language: "Test 3",
									  name: "Test 3",
									  story: "Test 3",
									  url: URL(string: "Test 3"))
	static let sourceApi4 = SourceApi(category: "Test 4",
									  country: "Test 4",
									  id: "Test 4",
									  language: "Test 4",
									  name: "Test 4",
									  story: "Test 4",
									  url: URL(string: "Test 4"))
	static let sourcesApi2 = SourcesApi(sources: [sourceApi3,
												  sourceApi4],
										status: "Test 2")
	static let topHeadlinesApi2 = TopHeadlinesApi(articles: [articleApi3,
															 articleApi4],
												  status: "Test 2",
												  totalResults: 2)
}
