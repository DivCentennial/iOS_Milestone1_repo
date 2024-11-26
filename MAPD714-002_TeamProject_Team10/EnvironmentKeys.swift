//
//  EnvironmentKeys.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-11-25.
//

import SwiftUI
import CoreData

// Define a custom EnvironmentKey for PhoneModel's managed object context
private struct PhoneContextKey: EnvironmentKey {
    static let defaultValue: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
}

// Extend EnvironmentValues to include the new key
extension EnvironmentValues {
    var phoneContext: NSManagedObjectContext {
        get { self[PhoneContextKey.self] }
        set { self[PhoneContextKey.self] = newValue }
    }
}

