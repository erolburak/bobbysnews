//
//  DetailView+LinearGradientOverlay.swift
//  BobbysNews
//
//  Created by Burak Erol on 23.06.25.
//

import SwiftUI

extension DetailView {
    // MARK: - Layouts

    func LinearGradientOverlay() -> some View {
        LinearGradient(
            stops: [
                Gradient.Stop(
                    color: .clear,
                    location: 0.6
                ),
                Gradient.Stop(
                    color: Color(uiColor: .systemBackground).opacity(0.8),
                    location: 0.8
                ),
                Gradient.Stop(
                    color: Color(uiColor: .systemBackground),
                    location: 1
                ),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
