//
//  ErrorsAPI.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 07.06.25.
//

import Foundation

public enum ErrorsAPI: LocalizedError {
    // MARK: - Properties

    case badRequest, forbidden, internalServerError, serviceUnavailable, tooManyRequests,
        unauthorized

    public var errorDescription: String? {
        switch self {
        case .badRequest:
            String(localized: "ErrorDescriptionBadRequest")
        case .forbidden:
            String(localized: "ErrorDescriptionForbidden")
        case .internalServerError:
            String(localized: "ErrorDescriptionInternalServerError")
        case .serviceUnavailable:
            String(localized: "ErrorDescriptionServiceUnavailable")
        case .tooManyRequests:
            String(localized: "ErrorDescriptionTooManyRequests")
        case .unauthorized:
            String(localized: "ErrorDescriptionUnauthorized")
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .badRequest:
            String(localized: "ErrorRecoverySuggestionBadRequest")
        case .forbidden:
            String(localized: "ErrorRecoverySuggestionForbidden")
        case .internalServerError:
            String(localized: "ErrorRecoverySuggestionInternalServerError")
        case .serviceUnavailable:
            String(localized: "ErrorRecoverySuggestionServiceUnavailable")
        case .tooManyRequests:
            String(localized: "ErrorRecoverySuggestionTooManyRequests")
        case .unauthorized:
            String(localized: "ErrorRecoverySuggestionUnauthorized")
        }
    }
}
