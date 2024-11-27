import SwiftUI
import CoreData

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode // For manual back navigation if needed
    @Binding var loggedInUsername: String? // Bind the login state to ContentView

    var username: String  // Receive username as a parameter

    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var address: String = ""
    @State private var cityCountry: String = ""
    @State private var telephone: String = ""

    @State private var navigateToBrandSelection: Bool = false // State to control navigation

    let primaryColor = Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)) // #BF387D Color

    var body: some View {
        NavigationView { // Wrap in a NavigationView
            ZStack {
                // Background color
                primaryColor
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    // Header: Profile title
                    Text("")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)

                    // Editable profile information section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Full Name:")
                        TextField("Enter full name", text: $fullName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.bottom, 10)

                        Text("Email:")
                        TextField("Enter email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.bottom, 10)

                        Text("Address:")
                        TextField("Enter address", text: $address)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.bottom, 10)

                        Text("City & Country:")
                        TextField("Enter city & country", text: $cityCountry)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.bottom, 10)

                        Text("Telephone:")
                        TextField("Enter telephone", text: $telephone)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.bottom, 20)
                    }
                    .padding()
                    .background(Color.white.opacity(0.9)) // Semi-transparent white background
                    .cornerRadius(15)
                    .padding()

                    // Save Button
                    Button(action: saveProfile) {
                        Text("Save Changes")
                            .frame(width: 200, height: 30)
                            .background(primaryColor)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top, 1)
                    }

                    // Button to navigate to the brand selection screen
                    NavigationLink(destination: BrandSelectionView(), isActive: $navigateToBrandSelection) {
                        Text("Select Phone Brand")
                            .frame(width: 200, height: 30)
                            .background(Color.white)
                            .foregroundColor(primaryColor) // Sets text color to #BF387D
                            .cornerRadius(8)
                            .padding(.top, 1) // Padding for button
                    }

                    Spacer() // Push content to the top
                }
                .padding()
            }
            .onAppear(perform: fetchProfileDetails)
            .navigationBarTitle("Profile", displayMode: .inline) // Navigation title
            .navigationBarItems(leading: backButton) // Add back button
        }
    }

    // Custom back button (Logout button)
    private var backButton: some View {
        Button(action: {
            // Reset login state to nil to log out
            loggedInUsername = nil
            // Dismiss current view
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left") // Back arrow icon
                    .foregroundColor(.white)
                Text("Logout")
                    .foregroundColor(.white)
            }
        }
    }

    private func fetchProfileDetails() {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first {
                fullName = user.fullname ?? "N/A"
                email = user.username ?? "N/A"
                address = user.address ?? "N/A"
                cityCountry = user.cityCountry ?? "N/A"
                telephone = user.telephone ?? "N/A"
            }
        } catch {
            print("Error fetching user details: \(error)")
        }
    }

    private func saveProfile() {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try viewContext.fetch(fetchRequest)
            if let user = users.first {
                user.fullname = fullName
                user.username = email // If email should be the username in Core Data
                user.address = address
                user.cityCountry = cityCountry
                user.telephone = telephone

                // Save context
                try viewContext.save()

                // After saving, navigate to the next screen
                navigateToBrandSelection = false // Trigger navigation to BrandSelectionView
            }
        } catch {
            print("Error saving profile: \(error)")
        }
    }
}
