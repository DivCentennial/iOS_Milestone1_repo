

 /*
  
  Name: - Divyanshoo Sinha (301486627)
        - Kashish Pramod Yadav (301485842)
        Project Milestone 2
        Group Project
        Team 10
      Overall Description: This milestone 2 we make a mobile shopping app where we integrate core data which is like database for ios.*/

 //
 //  ContentView.swift
 //  MAPD714-002_TeamProject_Team10
 //
 //  Created by Kashish Yadav on 2024-10-31.
 // Description: Opening page of the app with brand logo and slogan
 
 
// LoginView.swift: This file defines the login screen where users can input their credentials to authenticate, with navigation to the registration screen and toast messages for feedback.




import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var loggedInUsername: String? // Binding for the logged-in username
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var navigateToRegister = false

    var body: some View {
        ZStack {
            Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image("cenphone_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 200)
                    .padding(.top, 40)

                Text("Login")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.bottom, 20)

                Button(action: handleLogin) {
                    Text("Login")
                        .font(.headline)
                        .frame(width: 200, height: 50)
                        .background(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)

                NavigationLink(destination: RegisterView(), isActive: $navigateToRegister) {
                    Button(action: { navigateToRegister = true }) {
                        Text("Register")
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color.white.opacity(0.7))
                            .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                            .cornerRadius(10)
                    }
                    .padding()
                }

                if showToast {
                    Text(toastMessage)
                        .font(.subheadline)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.move(edge: .bottom))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                        }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func handleLogin() {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first, user.password == password {
                loggedInUsername = username // Update the logged-in username
            } else {
                toastMessage = "Invalid username or password"
                showToast = true
            }
        } catch {
            toastMessage = "Error during login"
            showToast = true
        }
    }
}
