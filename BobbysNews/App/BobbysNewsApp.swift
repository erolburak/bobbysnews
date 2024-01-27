//
//  BobbysNewsApp.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import SwiftUI

@main
struct BobbysNewsApp: App {

	// MARK: - Layouts

    var body: some Scene {
        WindowGroup {
			ContentView(viewModel: ViewModelFactory.shared.contentViewModel())
		}
    }
}
