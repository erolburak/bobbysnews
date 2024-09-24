//
//  Errors.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

import Foundation

public enum Errors: LocalizedError {
    // MARK: - Properties

    case error(String), fetchSources, fetchTopHeadlines, invalidApiKey, limitedRequests, noNetworkConnection, read, reset

    public var errorDescription: String? {
        switch self {
        case let .error(error):
            error.description
        case .fetchSources:
            String(localized: "ErrorDescriptionFetchSources")
        case .fetchTopHeadlines:
            String(localized: "ErrorDescriptionFetchTopHeadlines")
        case .invalidApiKey:
            String(localized: "ErrorDescriptionInvalidApiKey")
        case .limitedRequests:
            String(localized: "ErrorDescriptionLimitedRequests")
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
        case .error:
            String(localized: "ErrorRecoverySuggestionError")
        case .fetchSources:
            String(localized: "ErrorRecoverySuggestionFetchSources")
        case .fetchTopHeadlines:
            String(localized: "ErrorRecoverySuggestionFetchTopHeadlines")
        case .invalidApiKey:
            String(localized: "ErrorRecoverySuggestionInvalidApiKey")
        case .limitedRequests:
            String(localized: "ErrorRecoverySuggestionLimitedRequests")
        case .noNetworkConnection:
            String(localized: "ErrorRecoverySuggestionNoNetworkConnection")
        case .read:
            String(localized: "ErrorRecoverySuggestionRead")
        case .reset:
            String(localized: "ErrorRecoverySuggestionReset")
        }
    }
}
