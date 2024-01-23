//
//  ContentViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Combine
import SwiftUI

@Observable
class ContentViewModel {

	// MARK: - Type Definitions

	enum StateSources {
		/// General States
		case isLoading, loaded
		/// Empty States
		case emptyFetch, emptyRead
	}

	enum StateTopHeadlines {
		/// General States
		case isLoading, loaded
		/// Empty States
		case emptyFetch, emptyRead
	}

	// MARK: - Use Cases

	/// Sources
	private let deleteSourcesUseCase: PDeleteSourcesUseCase
	private let fetchRequestSourcesUseCase: PFetchRequestSourcesUseCase
	private let fetchSourcesUseCase: PFetchSourcesUseCase
	private let readSourcesUseCase: PReadSourcesUseCase
	/// TopHeadlines
	private let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
	private let fetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase
	private let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
	private let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase

	// MARK: - Properties

	var alertError: AppConfiguration.Errors?
	var apiKeyTotalAmount = AppConfiguration.apiKeyTotalAmount
	var apiKeyVersion = 1 {
		didSet {
			sensoryFeedback(feedback: .selection)
		}
	}
	var articles: [Article]?
	var countries: [String]?
	var listDisabled: Bool { stateTopHeadlines != .loaded }
	var listOpacity: Double { stateTopHeadlines == .loaded ? 1 : 0.3 }
	var selectedCountry = "" {
		didSet {
			articles?.removeAll()
			Task {
				await fetchTopHeadlines(state: .isLoading)
			}
		}
		willSet {
			if !newValue.isEmpty {
				sensoryFeedback(feedback: .selection)
			}
		}
	}
	var sensoryFeedback: SensoryFeedback = .success
	var sensoryFeedbackTrigger = false
	var showAlert = false
	var showConfirmationDialog = false
	var stateSources: StateSources = .isLoading
	var stateTopHeadlines: StateTopHeadlines = .isLoading

	// MARK: - Private Properties

	private var cancellable = Set<AnyCancellable>()

	// MARK: - Inits

	init(deleteSourcesUseCase: PDeleteSourcesUseCase,
		 fetchRequestSourcesUseCase: PFetchRequestSourcesUseCase,
		 fetchSourcesUseCase: PFetchSourcesUseCase,
		 readSourcesUseCase: PReadSourcesUseCase,
		 deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase,
		 fetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase,
		 fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase,
		 readTopHeadlinesUseCase: PReadTopHeadlinesUseCase) {
		self.deleteSourcesUseCase = deleteSourcesUseCase
		self.fetchRequestSourcesUseCase = fetchRequestSourcesUseCase
		self.fetchSourcesUseCase = fetchSourcesUseCase
		self.readSourcesUseCase = readSourcesUseCase
		self.deleteTopHeadlinesUseCase = deleteTopHeadlinesUseCase
		self.fetchRequestTopHeadlinesUseCase = fetchRequestTopHeadlinesUseCase
		self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
		self.readTopHeadlinesUseCase = readTopHeadlinesUseCase
	}

	func onAppear(selectedCountry: String) {
		self.selectedCountry = selectedCountry
		/// Bind sources, fetch from database and api
		readSources()
		fetchRequestSources()
		Task {
			await fetchSources()
		}
		/// Bind topHeadlines, fetch from database and api
		readTopHeadlines()
		fetchRequestTopHeadlines()
	}

	func onDisappear() {
		cancellable.removeAll()
	}

	func fetchSources(sensoryFeedback: Bool? = nil) async {
		stateSources = .isLoading
		
		do {
			try await fetchSourcesUseCase
				.fetch(apiKey: AppConfiguration.apiKey(apiKeyVersion))
		} catch {
			updateStateSources(completion: .failure(error),
							   state: countries?.isEmpty == true ? .emptyFetch : .loaded)
		}
	}

	func fetchTopHeadlines(state: StateTopHeadlines? = nil) async {
		if !selectedCountry.isEmpty {
			if let state {
				stateTopHeadlines = state
			}
			do {
				try await fetchTopHeadlinesUseCase
					.fetch(apiKey: AppConfiguration.apiKey(apiKeyVersion),
						   country: selectedCountry)
			} catch {
				updateStateTopHeadlines(completion: .failure(error),
										state: articles?.isEmpty == true ? .emptyFetch : .loaded)
			}
		}
	}

	func reset() {
		do {
			apiKeyVersion = 1
			selectedCountry = ""
			/// Delete all persisted sources
			try deleteSourcesUseCase
				.delete()
			countries = nil
			stateSources = .emptyRead
			/// Delete all persisted topHeadlines
			try deleteTopHeadlinesUseCase
				.delete(country: selectedCountry)
			articles = nil
			stateTopHeadlines = .emptyRead
			sensoryFeedback(feedback: .success)
		} catch {
			showAlert(error: .reset)
		}
	}

	private func fetchRequestSources() {
		fetchRequestSourcesUseCase
			.fetchRequest()
	}

	private func fetchRequestTopHeadlines() {
		if !selectedCountry.isEmpty {
			fetchRequestTopHeadlinesUseCase
				.fetchRequest(country: selectedCountry)
		}
	}

	private func readSources() {
		readSourcesUseCase
			.read()
			.compactMap { $0.sources }
			.receive(on: DispatchWorkloop.main)
			.sink(receiveCompletion: { [weak self] completion in
				if case .failure = completion {
					self?.updateStateSources(completion: completion,
											 state: .emptyRead)
				}
			}, receiveValue: { [weak self] sources in
				/// Set of unique countries
				let countries = Set(sources.compactMap { $0.country == "zh" ? "cn" : $0.country })
					.sorted(by: { lhs, rhs in
						Locale.current.localizedString(forRegionCode: lhs) ?? "" <= Locale.current.localizedString(forRegionCode: rhs) ?? ""})
				self?.countries = countries
				self?.updateStateSources(completion: .finished,
										 state: countries.isEmpty ? self?.stateSources == .emptyFetch ? .emptyFetch : .emptyRead : .loaded)
			})
			.store(in: &cancellable)
	}

	private func readTopHeadlines() {
		readTopHeadlinesUseCase
			.read()
			.compactMap { $0.articles }
			.receive(on: DispatchWorkloop.main)
			.sink(receiveCompletion: { [weak self] completion in
				if case .failure = completion {
					self?.updateStateTopHeadlines(completion: completion,
												  state: .emptyRead)
				}
			}, receiveValue: { [weak self] articles in
				self?.articles = articles
				DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(750)) {
					self?.updateStateTopHeadlines(completion: .finished,
												  state: articles.isEmpty ? self?.stateTopHeadlines == .emptyFetch ? .emptyFetch : .emptyRead : .loaded)
				}
			})
			.store(in: &cancellable)
	}

	private func sensoryFeedback(feedback: SensoryFeedback) {
		sensoryFeedback = feedback
		DispatchQueue.main.async {
			self.sensoryFeedbackTrigger = true
		}
	}

	private func showAlert(error: AppConfiguration.Errors) {
		alertError = error
		showAlert = true
		sensoryFeedback(feedback: .error)
	}

	private func updateStateSources(completion: Subscribers.Completion<Error>,
									state: StateSources) {
		switch completion {
		case .finished:
			stateSources = state
		case .failure(let error):
			stateSources = state
			showAlert(error: error as? AppConfiguration.Errors ?? .error(error.localizedDescription))
		}
	}

	private func updateStateTopHeadlines(completion: Subscribers.Completion<Error>,
										 state: StateTopHeadlines) {
		switch completion {
		case .finished:
			stateTopHeadlines = state
		case .failure(let error):
			stateTopHeadlines = state
			showAlert(error: error as? AppConfiguration.Errors ?? .error(error.localizedDescription))
		}
	}
}
