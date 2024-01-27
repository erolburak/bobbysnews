//
//  ViewModelFactory.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import BobbysNewsDomain

class ViewModelFactory {

	// MARK: - Private Properties

	private lazy var useCaseFactory = UseCaseFactory()

	// MARK: - Private Properties

	static let shared = ViewModelFactory()

	// MARK: - Actions

	func contentViewModel() -> ContentViewModel {
		ContentViewModel(deleteSourcesUseCase: useCaseFactory.deleteSourcesUseCase,
						 fetchSourcesUseCase: useCaseFactory.fetchSourcesUseCase,
						 readSourcesUseCase: useCaseFactory.readSourcesUseCase,
						 deleteTopHeadlinesUseCase: useCaseFactory.deleteTopHeadlinesUseCase,
						 fetchTopHeadlinesUseCase: useCaseFactory.fetchTopHeadlinesUseCase,
						 readTopHeadlinesUseCase: useCaseFactory.readTopHeadlinesUseCase)
	}

	func detailViewModel(article: Article) -> DetailViewModel {
		DetailViewModel(article: article)
	}
}