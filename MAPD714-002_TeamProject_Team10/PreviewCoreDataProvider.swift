//
//  PreviewCoreDataProvider.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-11-25.
//

import Foundation
import CoreData

class PreviewCoreDataProvider {
    static let shared = PreviewCoreDataProvider() // Singleton instance

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "YourModelName") // Replace "YourModelName" with your Core Data model name
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType // Use in-memory storage for preview
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory Core Data store: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
}

