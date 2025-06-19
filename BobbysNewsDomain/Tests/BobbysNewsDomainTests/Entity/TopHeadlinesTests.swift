//
//  TopHeadlinesTests.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import Foundation
import Testing

@testable import BobbysNewsDomain

@Suite("TopHeadlines tests")
struct TopHeadlinesTests {
    // MARK: - Methods

    @Test("Check TopHeadlines initializing!")
    func topHeadlines() {
        // Given
        let topHeadlines: TopHeadlines?
        // When
        topHeadlines = EntityMock.topHeadlines
        // Then
        #expect(
            topHeadlines?.articles?.first?.category == "Test"
                && topHeadlines?.articles?.first?.content == "Test"
                && topHeadlines?.articles?.first?.contentTranslated == nil
                && topHeadlines?.articles?.first?.country == "Test"
                && topHeadlines?.articles?.first?.image == URL(string: "Test")
                && topHeadlines?.articles?.first?.publishedAt == .distantPast
                && topHeadlines?.articles?.first?.showTranslations == false
                && topHeadlines?.articles?.first?.source?.name == "Test"
                && topHeadlines?.articles?.first?.source?.url == URL(string: "Test")
                && topHeadlines?.articles?.first?.story == "Test"
                && topHeadlines?.articles?.first?.title == "Test"
                && topHeadlines?.articles?.first?.titleTranslated == nil
                && topHeadlines?.articles?.first?.url == URL(string: "Test"),
            "TopHeadlines initializing failed!"
        )
    }
}
