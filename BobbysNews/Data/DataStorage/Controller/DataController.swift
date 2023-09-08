//
//  DataController.swift
//  BobbysNews
//
//  Created by Burak Erol on 31.08.23.
//

import Combine
import CoreData

class DataController {

	// MARK: - Properties

	static let shared = DataController()

	// MARK: - Private Properties

	private let container: NSPersistentCloudKitContainer
	lazy var backgroundContext = container.newBackgroundContext()

	// MARK: - Life Cycle

    init() {
        container = NSPersistentCloudKitContainer(name: "BobbysNews")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)!")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
