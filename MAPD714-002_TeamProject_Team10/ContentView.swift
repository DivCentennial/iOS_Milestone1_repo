//
//  ContentView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-10-31.
// Description: Opening page of the app with brand logo and slogan
//This is essentially a parent view to Login and Profile Views now.

import SwiftUI
import CoreData
struct ContentView: View {

    @State private var loggedInUsername: String? // Stores the logged-in username

    var body: some View {
        NavigationView {
            if let username = loggedInUsername {
                ProfileView(loggedInUsername: $loggedInUsername, username: username) // Pass the binding to ProfileView
    
            } else {
                LoginView(loggedInUsername: $loggedInUsername) // Pass the binding to LoginView
            }
        }
    }
}


//import SwiftUI
//
//struct ContentView: View {
//
//    var body: some View {
//        NavigationView { // Wrap the content in a NavigationView
//            VStack(spacing: 20) {
//
//                // Logo
//                Image("cenphone_logo") // Replace with your actual image name
//                    .resizable()
//                    .frame(width: 400, height: 360)
//
//                // Slogan
////                Text("Cenphone - The Future of Mobile")
////                    .font(.title)
////                    .multilineTextAlignment(.center)
//
//                // Order Now Button
//                NavigationLink(destination: BrandSelectionView()) { // Directly use NavigationLink
//                    Text("Order Now")
//                        .font(.headline)
//                        .frame(width: 200, height: 50)
//                        .background(Color.white)
//                        .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Sets text color to #BF387D
//                        .cornerRadius(8)
//                }
//            }
//            .padding(.top, 34)
//            .frame(maxWidth: .infinity, maxHeight: .infinity) // Makes the VStack take the full screen
//            .background(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Sets background to #BF387D
//            .ignoresSafeArea() // Extends background to cover entire screen
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
