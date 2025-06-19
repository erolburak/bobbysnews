//
//  ViewModelFactory.swift
//  BobbysNews
//
//  Created by Burak Erol on 03.09.23.
//

import BobbysNewsDomain
import SwiftUI

final class ViewModelFactory {
    // MARK: - Private Properties

    private let useCaseFactory = UseCaseFactory()

    // MARK: - Properties

    @MainActor
    static let shared = ViewModelFactory()

    // MARK: - Methods

    func contentViewModel() -> ContentViewModel {
        ContentViewModel(
            deleteTopHeadlinesUseCase: useCaseFactory.deleteTopHeadlinesUseCase,
            fetchTopHeadlinesUseCase: useCaseFactory.fetchTopHeadlinesUseCase,
            readTopHeadlinesUseCase: useCaseFactory.readTopHeadlinesUseCase
        )
    }

    func detailViewModel(
        article: Article,
        articleImage: Image?
    ) -> DetailViewModel {
        DetailViewModel(
            article: article,
            articleImage: articleImage
        )
    }
}
