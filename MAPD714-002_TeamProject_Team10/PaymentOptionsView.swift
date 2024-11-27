//
//  PaymentOptionsView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
//  User can select the payment method.


import SwiftUI

struct PaymentOptionsView: View {
    @EnvironmentObject var authManager: AuthManager // Access AuthManager from the environment
    
    @State private var selectedPaymentMethod = ""
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    
    // Parameters received from CustomerInfoView
    let brand: String
    let model: String
    let price: String
    let storage: String
    let color: String
    let customerName: String
    let address: String
    let city: String
    
    // Fetch AppUser from Core Data
    @FetchRequest(
        entity: AppUser.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \AppUser.fullname, ascending: true)],
        predicate: NSPredicate(format: "username == %@", "user2_username"), // Replace with actual logged-in username
        animation: .default
    ) var appUsers: FetchedResults<AppUser>

    
    // Extract user data (assuming only one user is present in Core Data)
       var appUser: AppUser? {
           return appUsers.first
       }
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Text("Select Payment Method")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.top, 20)
                    .padding(.leading, 26)

                Picker("Payment Method", selection: $selectedPaymentMethod) {
                    Text("Credit Card").tag("Credit Card")
                    Text("Debit Card").tag("Debit Card")
                    Text("Apple Pay / Google Pay").tag("Apple Pay / Google Pay")
                }
                .padding(.top, 40)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onAppear {
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 158/255, green: 47/255, blue: 102/255, alpha: 1.0)
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                }

                if selectedPaymentMethod == "Credit Card" || selectedPaymentMethod == "Debit Card" {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Card Information")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        TextField("Card Number", text: $cardNumber)
                            .accentColor(.white)
                            .foregroundColor(.white)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                        
                        TextField("Expiry Date (MM/YY)", text: $expiryDate)
                            .accentColor(.white)
                            .foregroundColor(.white)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                NavigationLink(destination: ConfirmationView(
                    brand: brand,
                    model: model,
                    price: price,
                    storage: storage,
                    color: color,
                    customerName: authManager.currentUser?.fullname ?? "Unknown",
                    address: authManager.currentUser?.address ?? "No Address",
                    city: authManager.currentUser?.cityCountry ?? "No City"
                )) {
                    Text("Confirm Order")
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                        .cornerRadius(8)
                        .padding(.top, 20)
                }
                .padding(.leading, 100)
                .padding(.bottom, 20)
            }
            .padding(.top)
        }
        .navigationBarTitle("Payment Options", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Payment Options")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
}

// Preview for PaymentOptionsView
struct PaymentOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PaymentOptionsView(
                brand: "iPhone",
                model: "iPhone 14",
                price: "$799",
                storage: "128 GB",
                color: "Blue",
                customerName: "John Doe",
                address: "123 Main Street",
                city: "Toronto"
              
            )
            .navigationBarTitle("Payment Options", displayMode: .inline)
        }
        .previewDevice("iPhone 14")
    }
}
