//
//  Errors.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

import Foundation

public enum Errors: LocalizedError {
    // MARK: - Properties

    case custom(String, String)
    case error(String)
    case fetchTopHeadlines, noNetworkConnection, read, reset

    public var errorDescription: String? {
        switch self {
        case .custom(let description, _):
            description
        case .error(let error):
            error.description
        case .fetchTopHeadlines:
            String(localized: "ErrorDescriptionFetchTopHeadlines")
        case .noNetworkConnection:
            String(localized: "ErrorDescriptionNoNetworkConnection")
        case .read:
            String(localized: "ErrorDescriptionRead")
        case .reset:
            String(localized: "ErrorDescriptionReset")
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .custom(_, let recoverySuggestion):
            recoverySuggestion
        case .error:
            String(localized: "ErrorRecoverySuggestionError")
        case .fetchTopHeadlines:
            String(localized: "ErrorRecoverySuggestionFetchTopHeadlines")
        case .noNetworkConnection:
            String(localized: "ErrorRecoverySuggestionNoNetworkConnection")
        case .read:
            String(localized: "ErrorRecoverySuggestionRead")
        case .reset:
            String(localized: "ErrorRecoverySuggestionReset")
        }
    }
}
