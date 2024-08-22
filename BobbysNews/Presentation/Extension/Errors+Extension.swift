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
        case .error(let error):
            return error.description
        case .fetchSources:
            return String(localized: "ErrorDescriptionFetchSources")
        case .fetchTopHeadlines:
            return String(localized: "ErrorDescriptionFetchTopHeadlines")
        case .invalidApiKey:
            return String(localized: "ErrorDescriptionInvalidApiKey")
        case .limitedRequests:
            return String(localized: "ErrorDescriptionLimitedRequests")
        case .read:
            return String(localized: "ErrorDescriptionRead")
        case .reset:
            return String(localized: "ErrorDescriptionReset")
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .error:
            return String(localized: "ErrorRecoverySuggestionError")
        case .fetchSources:
            return String(localized: "ErrorRecoverySuggestionFetchSources")
        case .fetchTopHeadlines:
            return String(localized: "ErrorRecoverySuggestionFetchTopHeadlines")
        case .invalidApiKey:
            return String(localized: "ErrorRecoverySuggestionInvalidApiKey")
        case .limitedRequests:
            return String(localized: "ErrorRecoverySuggestionLimitedRequests")
        case .read:
            return String(localized: "ErrorRecoverySuggestionRead")
        case .reset:
            return String(localized: "ErrorRecoverySuggestionReset")
        }
    }
}
