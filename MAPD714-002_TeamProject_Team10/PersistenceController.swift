//PersistenceController.swift
import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LoginModel")

        if inMemory {
            // Use in-memory store for testing purposes
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        } else {
            // Define the persistent store URL
            let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                .appendingPathComponent("LoginModel.sqlite")
            let storeDescription = container.persistentStoreDescriptions.first
            storeDescription?.url = storeURL
        }

        // Ensure store is not being loaded multiple times
        //resetPersistentStore()

        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Failed to get the persistent store description.")
        }

        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Loaded persistent store: \(storeDescription)")
            }
        }
    }


    func resetPersistentStore() {
        guard let storeURL = container.persistentStoreDescriptions.first?.url else {
            print("Persistent store URL not found.")
            return
        }

        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
            print("Persistent store successfully deleted.")
        } catch {
            print("Error deleting persistent store: \(error)")
        }

        // Reload the persistent store
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error after resetting: \(error), \(error.userInfo)")
            } else {
                print("Persistent store reloaded successfully.")
            }
        }
    }


    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Add mock data
        let newUser = AppUser(context: viewContext)
        newUser.fullname = "John Doe"
        newUser.address = "123 Main St"
        newUser.cityCountry = "City, Country"
        newUser.telephone = "123-456-7890"
        newUser.username = "john_doe@example.com"
        newUser.password = "password123"

        let newPhone = Phone(context: viewContext)
        newPhone.carrier = "Verizon"
        newPhone.phoneBrand = "Samsung"
        newPhone.phoneModel = "Galaxy S23"
        newPhone.phoneColor = "Black"
        newPhone.price = "799.99"
        newPhone.productId = UUID()
        newPhone.storageCapacity = "256GB"

        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }

        return controller
    }()
}
