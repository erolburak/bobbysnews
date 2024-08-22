//
//  DeleteTopHeadlinesUseCase.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 04.09.23.
//

import BobbysNewsData

public protocol PDeleteTopHeadlinesUseCase {
    // MARK: - Methods

    func delete() throws
}

public final class DeleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase {
    // MARK: - Private Properties

    private let topHeadlinesRepository: PTopHeadlinesRepository

    // MARK: - Lifecycles

    public init(topHeadlinesRepository: PTopHeadlinesRepository) {
        self.topHeadlinesRepository = topHeadlinesRepository
    }

    // MARK: - Methods

    public func delete() throws {
        try topHeadlinesRepository.delete()
    }
}
