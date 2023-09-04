//
//  ContentView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import SwiftUI

struct ContentView: View {

	// MARK: - Properties

	@State var viewModel: ContentViewModel

	// MARK: - Private Properties

	@AppStorage("country") private var country = Country.none

	// MARK: - Layouts

    var body: some View {
		NavigationStack {
			ScrollView(.vertical,
					   showsIndicators: false) {
				if viewModel.state == .loaded {
					ForEach(viewModel.articles ?? []) { article in
						NavigationLink(value: article) {
							Text(article.publishedAt?.toRelative ?? "") +
							Text(article.source.name ?? "")
						}
					}
					.navigationDestination(for: Article.self) { article in
						DetailView(viewModel: ViewModelDI.shared.detailViewModel(article: article))
					}
				}
			}
			.refreshable {
				await viewModel.fetchTopHeadlines()
			}
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button("Delete") {
						viewModel.delete()
					}
				}

				ToolbarItem(placement: .topBarTrailing) {
					Menu(viewModel.selectedCountry == .none ? "Select Country" : LocalizedStringKey(viewModel.selectedCountry.rawValue)) {
						ForEach(Country.allCases.filter { $0 != .none }.sorted(),
								id: \.rawValue) { item in
							Button(LocalizedStringKey(item.rawValue)) {
								country = item
							}
						}
					}
				}
			}
		}
		.overlay {
			switch viewModel.state {
			case .isLoading:
				ProgressView()
			case .emptyData:
				Text("EmptyData")
			case .emptyFetch:
				Text("EmptyFetch")
			case .noSelectedCountry:
				Text("NoSelectedCountry")
			default:
				EmptyView()
			}
		}
		.alert(isPresented: $viewModel.showAlert,
			   error: viewModel.alertError) { _ in
		} message: { error in
			if let message = error.recoverySuggestion {
				Text(message)
			}
		}
		.onAppear {
			viewModel.selectedCountry = country
			viewModel.onAppear()
		}
		.onDisappear() {
			viewModel.onDisappear()
		}
		.onChange(of: country) {
			viewModel.selectedCountry = country

			Task {
				await viewModel.fetchTopHeadlines(state: .isLoading)
			}
		}
    }
}

#Preview {
	ContentView(viewModel: ViewModelDI.shared.contentViewModel())
}
