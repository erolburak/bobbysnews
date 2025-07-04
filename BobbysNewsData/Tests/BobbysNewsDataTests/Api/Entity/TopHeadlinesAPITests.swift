//
//  TopHeadlinesAPITests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 04.09.23.
//

import Foundation
import Testing

@testable import BobbysNewsData

@Suite("TopHeadlinesAPI tests")
struct TopHeadlinesAPITests {
    // MARK: - Methods

    @Test("Check TopHeadlinesAPI initializing!")
    func topHeadlinesAPI() {
        // Given
        let topHeadlinesAPI: TopHeadlinesAPI?
        // When
        topHeadlinesAPI = EntityMock.topHeadlinesAPI
        // Then
        #expect(
            topHeadlinesAPI?.articles?.first?.content == "Test"
                && topHeadlinesAPI?.articles?.first?.image == URL(string: "Test")
                && topHeadlinesAPI?.articles?.first?.publishedAt == .distantPast
                && topHeadlinesAPI?.articles?.first?.source?.name == "Test"
                && topHeadlinesAPI?.articles?.first?.source?.url == URL(string: "Test")
                && topHeadlinesAPI?.articles?.first?.story == "Test"
                && topHeadlinesAPI?.articles?.first?.title == "Test"
                && topHeadlinesAPI?.articles?.first?.url == URL(string: "Test"),
            "TopHeadlinesAPI initializing failed!"
        )
    }
}
