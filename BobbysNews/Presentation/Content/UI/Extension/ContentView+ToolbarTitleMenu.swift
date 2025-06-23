//
//  ContentView+ToolbarTitleMenu.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.06.25.
//

import SwiftUI

extension ContentView {
    // MARK: - Layouts

    func ToolbarTitleMenu() -> some View {
        Picker(
            viewModel.selectedCategory.localized,
            systemImage: "tag",
            selection: $viewModel.selectedCategory
        ) {
            ForEach(
                viewModel.categoriesSorted,
                id: \.self
            ) {
                Text($0.localized)
                    .tag($0.localized)
            }
        }
        .pickerStyle(.automatic)
    }
}
