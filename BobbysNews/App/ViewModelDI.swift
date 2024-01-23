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
		ContentViewModel(deleteSourcesUseCase: DeleteSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
						 fetchRequestSourcesUseCase: FetchRequestSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
						 fetchSourcesUseCase: FetchSourcesUseCase(sourcesRepository: SourcesRepository()),
						 readSourcesUseCase: ReadSourcesUseCase(sourcesQueriesRepository: SourcesQueriesRepository()),
						 deleteTopHeadlinesUseCase: DeleteTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
						 fetchRequestTopHeadlinesUseCase: FetchRequestTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()),
						 fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCase(topHeadlinesRepository: TopHeadlinesRepository()),
						 readTopHeadlinesUseCase: ReadTopHeadlinesUseCase(topHeadlinesQueriesRepository: TopHeadlinesQueriesRepository()))
	}

	func detailViewModel(article: Article) -> DetailViewModel {
		DetailViewModel(article: article)
	}
}
