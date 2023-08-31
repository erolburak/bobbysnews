//
//  BobbysNewsApp.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import SwiftUI

@main
struct BobbysNewsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
