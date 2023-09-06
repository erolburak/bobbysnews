//
//  EntityMock.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 06.09.23.
//

@testable import BobbysNews
import Foundation

struct EntityMock {

	// MARK: - Properties

	static let article1 = Article(author: "Test 1",
								  content: "Test 1",
								  country: "Test 1",
								  publishedAt: "2001-02-03T12:34:56Z".toDate,
								  source: source1,
								  story: "Test 1",
								  title: "Test 1",
								  url: URL(string: "Test 1"),
								  urlToImage: URL(string: "Test 1"))
	static let article2 = Article(author: "Test 2",
								  content: "Test 2",
								  country: "Test 2",
								  publishedAt: "2001-02-03T12:34:56Z".toDate,
								  source: source2,
								  story: "Test 2",
								  title: "Test 2",
								  url: URL(string: "Test 2"),
								  urlToImage: URL(string: "Test 2"))
	static let source1 = Source(category: "Test 1",
								country: "Test 1",
								id: "Test 1",
								language: "Test 1",
								name: "Test 1",
								story: "Test 1",
								url: URL(string: "Test 1"))
	static let source2 = Source(category: "Test 2",
								country: "Test 2",
								id: "Test 2",
								language: "Test 2",
								name: "Test 2",
								story: "Test 2",
								url: URL(string: "Test 2"))
	static let sources1 = Sources(sources: [source1,
											source2],
								  status: "Test 1")
	static let topHeadlines1 = TopHeadlines(articles: [article1,
													   article2],
											status: "Test 1",
											totalResults: 2)
}
