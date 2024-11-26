//
//  PhonePersistenceController.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-11-25.
//

import Foundation
import CoreData

struct PhonePersistenceController {
    static let shared = PhonePersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PhoneModel") // Reference your new PhoneModel

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    // For Preview in SwiftUI
    static var preview: PhonePersistenceController = {
        let controller = PhonePersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Mock data for PhoneData
        let newPhone = PhoneData(context: viewContext)
        newPhone.productId = UUID()
        newPhone.phoneBrand = "Samsung"
        newPhone.phoneModel = "Galaxy S23"
        newPhone.phoneColor = "Phantom Black"
        newPhone.phoneStorage = "512GB"
        newPhone.phonePrice = "$1,299"

        do {
            try viewContext.save()
        } catch {
            print("Error saving mock data for preview: \(error)")
        }

        return controller
    }()
}
