import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext  // Access Core Data context
    @Binding var isLoggedIn: Bool
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    @State private var navigateToRegister = false

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
                    .frame(width: 250, height: 200) // Adjust the size as needed
                    .padding(.top, 40) // Add padding to give space from the top

                Text("Login")
                    .font(.largeTitle)
                    .foregroundColor(.white)  // White text for the title
                    .padding(.bottom, 20)

                // Username and Password Fields
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white.opacity(0.8))  // Light white background for text fields
                    .cornerRadius(10)  // Rounded corners
                    .padding(.bottom, 10)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.8))  // Light white background for password field
                    .cornerRadius(10)  // Rounded corners
                    .padding(.bottom, 20)
                
                // Login Button
                Button(action: handleLogin) {
                    Text("Login")
                        .font(.headline)
                        .frame(width: 200, height: 50)
                        .background(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Match the theme color
                        .foregroundColor(.white)
                        .cornerRadius(10)  // Rounded corners for button
                }
                .padding(.bottom, 10)

                // Register Button (Navigates to RegisterView)
                NavigationLink(destination: RegisterView(), isActive: $navigateToRegister) {
                    Button(action: handleRegister) {
                        Text("Register")
                            .font(.headline)
                            .frame(width: 200, height: 50)
                            .background(Color.white.opacity(0.7))
                            .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Same theme color for Register button
                            .cornerRadius(10)  // Rounded corners for Register button
                    }
                    .padding()
                }

                // Toast message when login fails
                if showToast {
                    Text(toastMessage)
                        .font(.subheadline)
                        .padding()
                        .background(Color.green)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures the VStack takes the entire screen
        }
    }

    private func handleLogin() {
        // Fetch request for the AppUser entity using username
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first, user.password == password {
                // Successful login
                isLoggedIn = true
            } else {
                toastMessage = "Invalid username or password"
                showToast = true
            }
        } catch {
            toastMessage = "Error during login"
            showToast = true
        }
    }

    private func handleRegister() {
        // Trigger navigation to Register screen
        navigateToRegister = true
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .previewLayout(.sizeThatFits)
        .padding()
}
