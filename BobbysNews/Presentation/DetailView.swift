//
//  DetailView.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import SwiftUI

struct DetailView: View {

	// MARK: - Properties

	@State var viewModel: DetailViewModel

	// MARK: - Layouts

	var body: some View {
		ScrollView(.vertical,
				   showsIndicators: false) {
			VStack {
				Text(viewModel.article.author ?? "")
				Text(viewModel.article.content ?? "")
				Text(viewModel.article.country ?? "")
				Text(viewModel.article.publishedAt?.toRelative ?? "")
				Text(viewModel.article.source?.category ?? "")
				Text(viewModel.article.source?.country ?? "")
				Text(viewModel.article.source?.id ?? "")
				Text(viewModel.article.source?.language ?? "")
				Text(viewModel.article.source?.name ?? "")
				Text(viewModel.article.source?.story ?? "")
				Text(viewModel.article.source?.url?.absoluteString ?? "")
				Text(viewModel.article.story ?? "")
				Text(viewModel.article.title ?? "")

				if let url = viewModel.article.url {
					Text(url, format: .url)
				}

				if let urlToImage = viewModel.article.urlToImage {
					AsyncImage(url: urlToImage) { image in
						image
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 150)
					} placeholder: {
						ProgressView()
					}
				}
			}
		}
	}
}

#Preview {
	DetailView(viewModel: ViewModelDI().detailViewModel(article: Article(author: nil,
																		 content: nil,
																		 country: nil,
																		 publishedAt: nil,
																		 source: Source(category: nil,
																						country: nil,
																						id: nil,
																						language: nil,
																						name: nil,
																						story: nil,
																						url: nil),
																		 story: nil,
																		 title: nil,
																		 url: nil,
																		 urlToImage: nil)))
}
