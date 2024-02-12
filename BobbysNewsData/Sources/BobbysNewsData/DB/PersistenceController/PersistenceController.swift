//
//  PersistenceController.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 31.08.23.
//

@preconcurrency
import CoreData
import Combine

public final class PersistenceController: Sendable {

	// MARK: - Properties

	public static let shared = PersistenceController()
	public let backgroundContext: NSManagedObjectContext

	// MARK: - Private Properties

	private let container: NSPersistentContainer

	// MARK: - Inits

	init() {
		guard let moduleUrl = Bundle.module.url(forResource: "BobbysNews",
												withExtension: "momd"),
			  let managedObjectModel = NSManagedObjectModel(contentsOf: moduleUrl) else {
			fatalError("Error initializing managed object model with module url!")
		}
		/// Disable cloud kit database if test scheme is running
		let isTestScheme = ProcessInfo().environment["XCTestConfigurationFilePath"] != nil
		container = isTestScheme ? NSPersistentContainer(name: "BobbysNews",
														 managedObjectModel: managedObjectModel) : NSPersistentCloudKitContainer(name: "BobbysNews",
																																 managedObjectModel: managedObjectModel)
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		container.viewContext.automaticallyMergesChangesFromParent = true
		backgroundContext = container.newBackgroundContext()
	}
}
