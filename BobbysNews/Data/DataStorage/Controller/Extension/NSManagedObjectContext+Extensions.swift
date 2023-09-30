//
//  NSManagedObjectContext+Extensions.swift
//  BobbysNews
//
//  Created by Burak Erol on 30.09.23.
//

import CoreData

extension NSManagedObjectContext {

	/// Execute and merge batch delete request on managed object context
	func executeAndMergeChanges(_ batchDeleteRequest: NSBatchDeleteRequest) throws {
		batchDeleteRequest.resultType = .resultTypeObjectIDs
		let batchDeleteResult = try execute(batchDeleteRequest) as? NSBatchDeleteResult
		let changes = [NSDeletedObjectsKey: batchDeleteResult?.result as? [NSManagedObjectID] ?? []]
		NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes,
											into: [self])
	}
}
