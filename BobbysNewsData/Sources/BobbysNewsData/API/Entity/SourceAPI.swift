//
//  SourceAPI.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

import Foundation

public struct SourceAPI: Decodable, Sendable {
    // MARK: - Properties

    public let name: String?
    public let url: URL?
}
