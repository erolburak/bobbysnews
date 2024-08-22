//
//  Errors+Extension.swift
//  BobbysNews
//
//  Created by Burak Erol on 24.01.24.
//

import BobbysNewsDomain

extension Errors {
    // MARK: - Properties

    var errorDescription: String? {
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
        case .read:
            String(localized: "ErrorDescriptionRead")
        case .reset:
            String(localized: "ErrorDescriptionReset")
        }
    }

    var recoverySuggestion: String? {
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
        case .read:
            String(localized: "ErrorRecoverySuggestionRead")
        case .reset:
            String(localized: "ErrorRecoverySuggestionReset")
        }
    }
}
