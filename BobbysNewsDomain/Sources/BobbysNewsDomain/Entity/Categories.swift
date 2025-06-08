//
//  Categories.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 07.06.25.
//

import Foundation

public enum Categories: String, CaseIterable, Sendable {
    // MARK: - Properties

    case business, entertainment, general, health, science, sports, technology, world

    public var localized: String {
        switch self {
        case .business:
            String(localized: "CategoryBusiness")
        case .entertainment:
            String(localized: "CategoryEntertainment")
        case .general:
            String(localized: "CategoryGeneral")
        case .health:
            String(localized: "CategoryHealth")
        case .science:
            String(localized: "CategoryScience")
        case .sports:
            String(localized: "CategorySports")
        case .technology:
            String(localized: "CategoryTechnology")
        case .world:
            String(localized: "CategoryWorld")
        }
    }
}
