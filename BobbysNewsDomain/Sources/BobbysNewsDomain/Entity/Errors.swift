//
//  Errors.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 24.01.24.
//

import Foundation

public enum Errors: LocalizedError {

	// MARK: - Properties

	case error(String), fetchSources, fetchTopHeadlines, invalidApiKey, limitedRequests, read, reset
}
