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
			ContentView(viewModel: ViewModelDI.shared.contentViewModel())
        }
    }
}

// TODO: Add Share Link
// TODO: Add In App WebView
// TODO: Update Views
// TODO: Update Localizable
// TODO: Add UI Tests
