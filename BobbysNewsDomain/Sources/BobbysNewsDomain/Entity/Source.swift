//
//  Source.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 01.09.23.
//

import Foundation

public struct Source: Hashable, Sendable {
    // MARK: - Properties

    public let name: String?
    public let url: URL?

    // MARK: - Lifecycles

    public init(
        name: String?,
        url: URL?
    ) {
        self.name = name
        self.url = url
    }
}
