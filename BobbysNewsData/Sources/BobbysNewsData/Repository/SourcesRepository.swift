//
//  SourcesRepository.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.09.23.
//

public protocol PSourcesRepository: Sendable {
    // MARK: - Methods

    func delete() throws
    func fetch(apiKey: Int) async throws
    func read() throws -> [SourceDB]
}

final class SourcesRepository: PSourcesRepository {
    // MARK: - Private Properties

    private let sourcesPersistenceController = SourcesPersistenceController()
    private let sourcesNetworkController = SourcesNetworkController()

    // MARK: - Methods

    func delete() throws {
        try sourcesPersistenceController.delete()
    }

    func fetch(apiKey: Int) async throws {
        let sourcesAPI = try await sourcesNetworkController.fetch(apiKey: apiKey)
        if sourcesAPI.sources != nil ||
            sourcesAPI.sources?.isEmpty == false
        {
            try sourcesPersistenceController.save(sourcesAPI: sourcesAPI)
        } else {
            try delete()
        }
    }

    func read() throws -> [SourceDB] {
        try sourcesPersistenceController.read()
    }
}
