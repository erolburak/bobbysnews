//
//  ContentViewModel.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Combine
import Foundation

@Observable
class ContentViewModel {

	// MARK: - Type Definitions

	enum StateSources {
		/// General States
		case isInitialLoading, isLoading, loaded, load
		/// Empty States
		case emptyFetch, emptyRead
	}

	enum StateTopHeadlines {
		/// General States
		case isInitialLoading, isLoading, loaded
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
	var apiKeys: [AppConfiguration.ApiKey] = { AppConfiguration.ApiKey.allCases }()
	var articles: [Article]?
	var countries: [String]?
	var selectedApiKey = AppConfiguration.ApiKey.first
	var selectedCountry: String?
	var showAlert = false
	var sources: [Source]?
	var stateSources: StateSources = .isInitialLoading
	var stateTopHeadlines: StateTopHeadlines = .isInitialLoading

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

	func onAppear(country: String) {
		selectedCountry = !country.isEmpty ? country : nil
		/// Bind sources and fetch from database
		readSources()
		fetchRequestSources()
		/// Bind topHeadlines and fetch from database
		readTopHeadlines()
		fetchRequestTopHeadlines()
		Task {
			/// Fetch sources and topHeadlines from api
			await fetchSources(state: .isInitialLoading)
			await fetchTopHeadlines(state: .isInitialLoading)
		}
	}

	func onDisappear() {
		cancellable.removeAll()
	}

	func delete() {
		do {
			try deleteSourcesUseCase
				.delete()
			try deleteTopHeadlinesUseCase
				.delete()
			selectedCountry = nil
			stateSources = .load
			stateTopHeadlines = .emptyRead
		} catch {
			showAlert(error: .delete)
		}
	}

	func fetchSources(state: StateSources? = nil) async {
		if let state {
			stateSources = state
			fetchSourcesUseCase
				.fetch(apiKey: selectedApiKey.key)
				.sink { [weak self] completion in
					self?.updateStateSources(completion: completion,
											 failureState: .emptyFetch)
				} receiveValue: { [weak self] sourcesDto in
					self?.saveSourcesUseCase
						.save(sourcesDto: sourcesDto)
				}
				.store(in: &cancellable)
		}
	}

	func fetchTopHeadlines(state: StateTopHeadlines? = nil) async {
		if let selectedCountry,
		   let state {
			stateTopHeadlines = state
			fetchTopHeadlinesUseCase
				.fetch(apiKey: selectedApiKey.key,
					   country: selectedCountry)
				.sink { [weak self] completion in
					self?.updateStateTopHeadlines(completion: completion,
												  failureState: .emptyFetch)
				} receiveValue: { [weak self] topHeadlinesDto in
					self?.saveTopHeadlinesUseCase
						.save(country: selectedCountry,
							  topHeadlinesDto: topHeadlinesDto)
				}
				.store(in: &cancellable)
		}
	}

	private func fetchRequestSources() {
		fetchRequestSourcesUseCase
			.fetchRequest()
	}

	private func fetchRequestTopHeadlines() {
		if let selectedCountry {
			fetchRequestTopHeadlinesUseCase
				.fetchRequest(country: selectedCountry)
		}
	}

	private func readSources() {
		readSourcesUseCase
			.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { [weak self] sources in
				self?.sources = sources.sources
				/// Sorted set of unique country codes
				self?.countries = Array(Set(sources.sources?.compactMap { $0.country } ?? []).sorted(by: <))
				self?.updateStateSources(completion: sources.sources?.isEmpty == false ? .finished : self?.stateSources != .isInitialLoading ? .failure(AppConfiguration.Errors.read) : .finished,
										 failureState: .emptyRead)
			})
			.store(in: &cancellable)
	}

	private func readTopHeadlines() {
		readTopHeadlinesUseCase
			.read()
			.sink(receiveCompletion: { _ in },
				  receiveValue: { [weak self] topHeadlines in
				self?.articles = topHeadlines.articles
				self?.updateStateTopHeadlines(completion: topHeadlines.articles?.isEmpty == false ? .finished : self?.stateTopHeadlines != .isInitialLoading ? .failure(AppConfiguration.Errors.read) : .finished,
											  failureState: .emptyRead)
			})
			.store(in: &cancellable)
	}

	private func showAlert(error: AppConfiguration.Errors) {
		alertError = error
		showAlert = true
	}

	private func updateStateSources(completion: Subscribers.Completion<Error>,
									failureState: StateSources) {
		switch completion {
		case .finished:
			stateSources = .loaded
		case .failure(let error):
			stateSources = failureState
			showAlert(error: error as? AppConfiguration.Errors ?? .error(error.localizedDescription))
		}
	}

	private func updateStateTopHeadlines(completion: Subscribers.Completion<Error>,
										 failureState: StateTopHeadlines) {
		switch completion {
		case .finished:
			stateTopHeadlines = .loaded
		case .failure(let error):
			stateTopHeadlines = failureState
			showAlert(error: error as? AppConfiguration.Errors ?? .error(error.localizedDescription))
		}
	}
}
