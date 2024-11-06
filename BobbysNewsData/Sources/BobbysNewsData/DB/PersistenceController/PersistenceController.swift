//
//  PersistenceController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

import CoreData

public final class PersistenceController {
    // MARK: - Private Properties

    private let container: NSPersistentContainer

    // MARK: - Properties

    public nonisolated(unsafe)
    static let shared = PersistenceController()
    public let backgroundContext: NSManagedObjectContext

    // MARK: - Lifecycles

    init() {
        guard let moduleUrl = Bundle.module.url(forResource: "BobbysNews",
                                                withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOf: moduleUrl)
        else {
            fatalError("Error initializing managed object model with module url!")
        }
        let cloudKitContainer = NSPersistentCloudKitContainer(name: "BobbysNews",
                                                              managedObjectModel: managedObjectModel)
        #if DEBUG
            container = CommandLine.arguments.contains("-testing") ? NSPersistentContainer(name: "BobbysNews",
                                                                                           managedObjectModel: managedObjectModel) : cloudKitContainer
        #else
            container = cloudKitContainer
        #endif
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext = container.newBackgroundContext()
    }
}
