//
//  DetailViewModelTests.swift
//  BobbysNewsTests
//
//  Created by Burak Erol on 31.08.23.
//

import Testing

struct DetailViewModelTests {

	// MARK: - Actions

	@Test("Check initializing DetailViewModel!")
	func testDetailViewModel() {
		// Given
		let article = EntityMock.article
		let detailViewModel: DetailViewModel?
		// When
		detailViewModel = DetailViewModel(article: article)
		// Then
		#expect(detailViewModel != nil,
				"Initializing DetailViewModel failed!")
		#expect(detailViewModel?.article.author == article.author,
				"Initializing DetailViewModel article.author failed!")
		#expect(detailViewModel?.article.content == article.content,
				"Initializing DetailViewModel article.content failed!")
		#expect(detailViewModel?.article.publishedAt == article.publishedAt,
				"Initializing DetailViewModel article.publishedAt failed!")
		#expect(detailViewModel?.article.source?.category == article.source?.category,
				"Initializing DetailViewModel article.source?.category failed!")
		#expect(detailViewModel?.article.source?.country == article.source?.country,
				"Initializing DetailViewModel article.source?.country failed!")
		#expect(detailViewModel?.article.source?.id == article.source?.id,
				"Initializing DetailViewModel article.source?.id failed!")
		#expect(detailViewModel?.article.source?.language == article.source?.language,
				"Initializing DetailViewModel article.source?.language failed!")
		#expect(detailViewModel?.article.source?.name == article.source?.name,
				"Initializing DetailViewModel article.source?.name failed!")
		#expect(detailViewModel?.article.source?.story == article.source?.story,
				"Initializing DetailViewModel article.source?.story failed!")
		#expect(detailViewModel?.article.source?.url == article.source?.url,
				"Initializing DetailViewModel article.source?.url failed!")
		#expect(detailViewModel?.article.story == article.story,
				"Initializing DetailViewModel article.story failed!")
		#expect(detailViewModel?.article.title == article.title,
				"Initializing DetailViewModel article.title failed!")
		#expect(detailViewModel?.article.url == article.url,
				"Initializing DetailViewModel article.url failed!")
		#expect(detailViewModel?.article.urlToImage == article.urlToImage,
				"Initializing DetailViewModel article.urlToImage failed!")
	}
}
