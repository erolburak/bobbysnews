//
//  SourceAPI.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

public struct SourceAPI: Decodable, Sendable {
    // MARK: - Type Definitions

    private enum CodingKeys: String, CodingKey {
        case category, country, id, language, name, url
        case story = "description"
    }

    // MARK: - Properties

    public let category: String?
    public let country: String?
    public let id: String?
    public let language: String?
    public let name: String?
    public let story: String?
    public let url: URL?
}
