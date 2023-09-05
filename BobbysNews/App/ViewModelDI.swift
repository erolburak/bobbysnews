//
//  ViewModelDI.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

struct ViewModelDI {

	// MARK: - Properties

	static let shared = ViewModelDI()

	// MARK: - Actions

	func contentViewModel() -> ContentViewModel {
		ContentViewModel(deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
						 fetchRequestTopHeadlinesUseCase: FetchRequestTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
						 fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: TopHeadlinesRepository()),
						 readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
						 saveTopHeadlinesUseCase: SaveTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
						 fetchRequestTopHeadlinesSourcesUseCase: FetchRequestTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
						 fetchTopHeadlinesSourcesUseCase: FetchTopHeadlinesSourcesUseCase(topHeadlinesRepository: TopHeadlinesRepository()),
						 readTopHeadlinesSourcesUseCase: ReadTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
						 saveTopHeadlinesSourcesUseCase: SaveTopHeadlinesSourcesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()))
	}

	func detailViewModel(article: Article) -> DetailViewModel {
		DetailViewModel(article: article)
	}
}
