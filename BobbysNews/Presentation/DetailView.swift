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
				Text(viewModel.article.source.id ?? "")
				Text(viewModel.article.source.name ?? "")
				Text(viewModel.article.author ?? "")
				Text(viewModel.article.country.rawValue)
				Text(viewModel.article.title ?? "")
				Text(viewModel.article.story ?? "")

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

				Text(viewModel.article.publishedAt?.toRelative ?? "")
				Text(viewModel.article.content ?? "")
			}
		}
	}
}

#Preview {
	DetailView(viewModel: DetailViewModel(article: Article(author: nil,
														   content: nil,
														   country: .none,
														   publishedAt: nil,
														   source: Source(id: nil,
																		  name: nil),
														   story: nil,
														   title: nil,
														   url: nil,
														   urlToImage: nil)))
}
