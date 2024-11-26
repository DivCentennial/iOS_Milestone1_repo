/*
 
 Name: - Divyanshoo Sinha (301486627)
       - Kashish Pramod Yadav (301485842)
       Project Milestone 2
       Group Project
       Team 10
     Overall Description: Overall Description: This milestone 2 we make a mobile shopping app where we integrate core data which is like database for ios.*/



//
//  MAPD714_002_TeamProject_Team10App.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-10-31.
//

import SwiftUI

@main
struct MAPD714_002_TeamProject_Team10App: App {
    // Create an instance of the PersistenceController
    let persistenceController = PersistenceController.shared // Singleton instance

    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(.white)
                // Inject the viewContext from the instance of PersistenceController
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
