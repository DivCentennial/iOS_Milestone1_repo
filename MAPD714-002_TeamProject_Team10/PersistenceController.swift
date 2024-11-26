//
//  PersistenceController.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-11-25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LoginModel") // Replace with your model name

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Loaded persistent store: \(storeDescription)")
            }
        }
    }
    // Provide access to the viewContext
        var viewContext: NSManagedObjectContext {
            return container.viewContext
        }

    // For Preview in SwiftUI
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Create mock data for the preview
        let newUser = AppUser(context: viewContext)
        newUser.fullname = "John Doe"
        newUser.address = "123 Main St"
        newUser.cityCountry = "City, Country"
        newUser.telephone = "123-456-7890"
//        newUser.email = "john@example.com"
        newUser.username = "john_doe"
        newUser.password = "securepassword"
        

        do {
            try viewContext.save()
        } catch {
            print("Error saving mock data for preview: \(error)")
        }

        return controller
    }()
}

