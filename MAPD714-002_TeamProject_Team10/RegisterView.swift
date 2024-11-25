//
//  RegisterView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Kashish Yadav on 2024-11-25.
//

import SwiftUI
import CoreData

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var fullName: String = ""
    @State private var address: String = ""
    @State private var cityCountry: String = ""
    @State private var telephone: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""

    @State private var registrationMessage: String = ""

    var body: some View {
        ZStack {
            // Pink background that extends to cover the entire screen
            Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)) // Match background color
                .edgesIgnoringSafeArea(.all) // Makes the background color cover the whole screen

            VStack {
                // Cenphone Logo at the top
                Image("cenphone_logo") // Ensure the image name matches your asset
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150) // Adjust the size as needed
                    .padding(.top, 10) // Add padding to give space from the top

                Text("Register")
                    .font(.title3)
                    .foregroundColor(.white)  // White text for the title
                    .padding(.bottom, 10)

                // Input Fields with consistent styling
                Group {
                    TextField("Full Name", text: $fullName)
                    TextField("Address", text: $address)
                    TextField("City and Country", text: $cityCountry)
                    TextField("Telephone", text: $telephone)
                    TextField("Email", text: $username)
//                    TextField("Username (optional)", text: $username)
                    SecureField("Password", text: $password)
                }
                .padding()
                .background(Color.white.opacity(0.8))  // Light white background for text fields
                .cornerRadius(10)  // Rounded corners
                .padding(.bottom, 10)
                .frame(width: 300)

                // Register Button
                Button(action: handleRegister) {
                    Text("Submit")
                        .font(.headline)
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                        .cornerRadius(10)  // Rounded corners for button
                }
                .padding(.bottom, 10)

                // Status Message
                if !registrationMessage.isEmpty {
                    Text(registrationMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the VStack takes the entire screen
        }
    }

    private func handleRegister() {
        guard !fullName.isEmpty, !username.isEmpty, !password.isEmpty else {
            registrationMessage = "Please fill in all required fields."
            return
        }

        // Use email as username if username is not provided
        let finalUsername = username.isEmpty ? email : username

        // Save to Core Data
        let newUser = AppUser(context: viewContext)
        newUser.fullname = fullName
        newUser.address = address
        newUser.cityCountry = cityCountry
        newUser.telephone = telephone
        newUser.username = finalUsername
        newUser.password = password

        do {
            try viewContext.save()
            registrationMessage = "Registration successful!"
        } catch {
            registrationMessage = "Failed to register. Please try again."
        }
    }
}

#Preview {
    RegisterView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .previewLayout(.sizeThatFits)
        .padding()
}
