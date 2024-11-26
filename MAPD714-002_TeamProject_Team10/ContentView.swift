/*
 
 Name: - Divyanshoo Sinha (301486627)
       - Kashish Pramod Yadav (301485842)
       Project Milestone 1
       Group Project
       Team 10
     Overall Description: This milestone 1 we make a mobile shopping app where we can shop different brands with their respective models using SWIFT UI.*/

//
//  ContentView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-10-31.
// Description: Opening page of the app with brand logo and slogan 


import SwiftUI

struct ContentView: View {
    @Environment(\.phoneContext) private var phoneContext // Access PhoneModel context
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            if isLoggedIn {
                BrandSelectionView()
                    .environment(\.phoneContext, phoneContext) // Inject phoneContext to child views
            } else {
                LoginView(isLoggedIn: $isLoggedIn) // Pass the binding to LoginView
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


