//
//  DetailView+OffsetOverlay.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.06.25.
//

import SwiftUI

extension DetailView {
    // MARK: - Layouts

    func OffsetOverlay() -> some View {
        Color(uiColor: .systemBackground)
            .frame(height: viewModel.scrollGeometryYOffset + 10)
            .padding(
                .bottom,
                -10
            )
            .offset(y: viewModel.scrollGeometryYOffset)
            .ignoresSafeArea()
    }
}
