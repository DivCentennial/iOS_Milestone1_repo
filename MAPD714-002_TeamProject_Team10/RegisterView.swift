// RegisterView.swift: This file defines the registration screen where users can create a new account by entering their details, which are saved to Core Data, with feedback provided through toast messages.


import SwiftUI
import CoreData

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss  // Dismiss environment to go back

    @State private var fullName: String = ""
    @State private var address: String = ""
    @State private var cityCountry: String = ""
    @State private var telephone: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var toastColor: Color = .red

    var body: some View {
        ZStack {
            Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image("cenphone_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 100)

                Text("Register")
                    .font(.title3)
                    .foregroundColor(.white)

                Group {
                    TextField("Full Name", text: $fullName)
                    TextField("Address", text: $address)
                    TextField("City and Country", text: $cityCountry)
                    TextField("Telephone", text: $telephone)
                    TextField("Email", text: $username).autocapitalization(.none)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding(.bottom, 10)
                .frame(width: 300)

                Button(action: handleRegister) {
                    Text("Submit")
                        .font(.headline)
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)

                if showToast {
                    Text(toastMessage)
                        .font(.subheadline)
                        .padding()
                        .background(toastColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showToast = false
                                }

                                if toastColor == .green {
                                    dismiss()  // Navigate back if registration is successful
                                }
                            }
                        }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func handleRegister() {
        guard !fullName.isEmpty, !username.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            toastMessage = "Please fill in all required fields."
            toastColor = .red
            showToast = true
            return
        }

        guard password == confirmPassword else {
            toastMessage = "Passwords do not match."
            toastColor = .red
            showToast = true
            return
        }

        let finalUsername = username.isEmpty ? email : username

        let newUser = AppUser(context: viewContext)
        newUser.fullname = fullName
        newUser.address = address
        newUser.cityCountry = cityCountry
        newUser.telephone = telephone
        newUser.username = finalUsername
        newUser.password = password

        do {
            try viewContext.save()
            toastMessage = "Registration successful!"
            toastColor = .green
            showToast = true
        } catch {
            toastMessage = "Failed to register. Please try again."
            toastColor = .red
            showToast = true
        }
    }
}

#Preview {
    RegisterView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .previewLayout(.sizeThatFits)
        .padding()
}
