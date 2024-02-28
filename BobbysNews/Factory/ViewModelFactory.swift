//
//  ViewModelFactory.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

@preconcurrency
import BobbysNewsDomain
import SwiftUI

final class ViewModelFactory: Sendable {

	// MARK: - Private Properties

	private let useCaseFactory = UseCaseFactory()

	// MARK: - Properties

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
