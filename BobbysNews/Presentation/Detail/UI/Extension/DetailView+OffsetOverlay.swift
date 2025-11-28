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
            .frame(height: viewModel.scrollGeometryContentOffsetY)
            .offset(y: viewModel.scrollGeometryContentOffsetY)
            .ignoresSafeArea()
    }
}
