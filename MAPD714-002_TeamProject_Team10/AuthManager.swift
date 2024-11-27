//
//  AuthManager.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-11-26.
//
import Foundation
import CoreData

class AuthManager: ObservableObject {
    @Published var currentUser: AppUser?

    // Function to set the current user
    func setCurrentUser(user: AppUser) {
        self.currentUser = user
    }

    // Function to get the current user, if needed
    func getCurrentUser() -> AppUser? {
        return self.currentUser
    }
}

