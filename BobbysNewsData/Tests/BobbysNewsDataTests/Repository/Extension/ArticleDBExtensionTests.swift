//
//  ArticleDBExtensionTests.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

@testable import BobbysNewsData
import Testing

@Suite("ArticleDBExtension tests")
struct ArticleDBExtensionTests {
    // MARK: - Methods

    @Test("Check ArticleDB initializing!")
    func articleDB() {
        // Given
        let articleAPI = EntityMock.articleAPI
        // When
        let articleDB = ArticleDB(from: articleAPI,
                                  category: "Test",
                                  country: "Test")
        // Then
        #expect(articleDB.content == articleAPI.content &&
            articleDB.image == articleAPI.image &&
            articleDB.publishedAt == articleAPI.publishedAt &&
            articleDB.source?.name == articleAPI.source?.name &&
            articleDB.source?.url == articleAPI.source?.url &&
            articleDB.story == articleAPI.story &&
            articleDB.title == articleAPI.title &&
            articleDB.url == articleAPI.url,
            "ArticleDB initializing failed!")
    }
}
