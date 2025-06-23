//
//  DetailView+Toolbar.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.06.25.
//

import SwiftUI

extension DetailView {
    // MARK: - Layouts

    @ToolbarContentBuilder
    func Toolbar() -> some ToolbarContent {
        if let url = viewModel.article.url {
            ToolbarItem(placement: .primaryAction) {
                ShareLink(item: url)
                    .accessibilityIdentifier("ShareLink")
            }
        }
    }
}
