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
	private let saveSourcesUseCase: PSaveSourcesUseCase
	/// TopHeadlines
	private let deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase
	private let fetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase
	private let fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase
	private let readTopHeadlinesUseCase: PReadTopHeadlinesUseCase
	private let saveTopHeadlinesUseCase: PSaveTopHeadlinesUseCase

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
	var showConfirmationDialogPad = false
	var showConfirmationDialogPhone = false
	var stateSources: StateSources = .isLoading
	var stateTopHeadlines: StateTopHeadlines = .isLoading

	// MARK: - Private Properties

	private var cancellable = Set<AnyCancellable>()

	// MARK: - Life Cycle

	init(deleteSourcesUseCase: PDeleteSourcesUseCase,
		 fetchRequestSourcesUseCase: PFetchRequestSourcesUseCase,
		 fetchSourcesUseCase: PFetchSourcesUseCase,
		 readSourcesUseCase: PReadSourcesUseCase,
		 saveSourcesUseCase: PSaveSourcesUseCase,
		 deleteTopHeadlinesUseCase: PDeleteTopHeadlinesUseCase,
		 fetchRequestTopHeadlinesUseCase: PFetchRequestTopHeadlinesUseCase,
		 fetchTopHeadlinesUseCase: PFetchTopHeadlinesUseCase,
		 readTopHeadlinesUseCase: PReadTopHeadlinesUseCase,
		 saveTopHeadlinesUseCase: PSaveTopHeadlinesUseCase) {
		self.deleteSourcesUseCase = deleteSourcesUseCase
		self.fetchRequestSourcesUseCase = fetchRequestSourcesUseCase
		self.fetchSourcesUseCase = fetchSourcesUseCase
		self.readSourcesUseCase = readSourcesUseCase
		self.saveSourcesUseCase = saveSourcesUseCase
		self.deleteTopHeadlinesUseCase = deleteTopHeadlinesUseCase
		self.fetchRequestTopHeadlinesUseCase = fetchRequestTopHeadlinesUseCase
		self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
		self.readTopHeadlinesUseCase = readTopHeadlinesUseCase
		self.saveTopHeadlinesUseCase = saveTopHeadlinesUseCase
	}

	func onAppear(selectedCountry: String) {
		self.selectedCountry = selectedCountry
		/// Bind sources, fetch from database and api
		readSources()
		fetchRequestSources()
		fetchSources()
		/// Bind topHeadlines, fetch from database and api
		readTopHeadlines()
		fetchRequestTopHeadlines()
	}

	func onDisappear() {
		cancellable.removeAll()
	}

	func fetchSources(sensoryFeedback: Bool? = nil) {
		stateSources = .isLoading
		fetchSourcesUseCase
			.fetch(apiKey: AppConfiguration.apiKey(apiKeyVersion))
			.receive(on: DispatchWorkloop.main)
			.sink { [weak self] completion in
				if case .failure = completion {
					self?.updateStateSources(completion: completion,
											 state: self?.countries?.isEmpty == true ? .emptyFetch : .loaded)
				}
			} receiveValue: { [weak self] sourcesDto in
				if sourcesDto.sources != nil ||
					sourcesDto.sources?.isEmpty == false {
					self?.saveSourcesUseCase
						.save(sourcesDto: sourcesDto)
					if sensoryFeedback == true {
						self?.sensoryFeedback(feedback: .success)
					}
				} else {
					self?.updateStateSources(completion: .finished,
											 state: .emptyFetch)
					do {
						try self?.deleteSourcesUseCase
							.delete()
						self?.countries?.removeAll()
						self?.updateStateSources(completion: .finished,
												 state: .emptyFetch)
					} catch {
						self?.showAlert(error: .error(error.localizedDescription))
					}
				}
			}
			.store(in: &cancellable)
	}

	func fetchTopHeadlines(state: StateTopHeadlines? = nil) async {
		if !selectedCountry.isEmpty {
			if let state {
				stateTopHeadlines = state
			}
			do {
				let topHeadlinesDto = try await fetchTopHeadlinesUseCase
					.fetch(apiKey: AppConfiguration.apiKey(apiKeyVersion),
						   country: selectedCountry)
				if topHeadlinesDto.articles != nil ||
					topHeadlinesDto.articles?.isEmpty == false {
					saveTopHeadlinesUseCase
						.save(country: selectedCountry,
							  topHeadlinesDto: topHeadlinesDto)
				} else {
					do {
						try deleteTopHeadlinesUseCase
							.delete(country: selectedCountry)
						articles?.removeAll()
						updateStateTopHeadlines(completion: .finished,
												state: .emptyFetch)
					} catch {
						showAlert(error: .error(error.localizedDescription))
					}
				}
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
