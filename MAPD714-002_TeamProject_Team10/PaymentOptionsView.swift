//
//  PaymentOptionsView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
//  User can select the payment method.


import SwiftUI

struct PaymentOptionsView: View {
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
    let postalCode: String

    var body: some View {
        ZStack {
            // Set the background color for the entire screen
            Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Text("Select Payment Method")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.top, 20)
                    .padding(.leading, 26) // Add left padding
                
                Picker("Payment Method", selection: $selectedPaymentMethod) {
                    Text("Credit Card").tag("Credit Card")
                    Text("Debit Card").tag("Debit Card")
                    Text("Apple Pay / Google Pay").tag("Apple Pay / Google Pay")
                }
                .padding(.top, 40)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onAppear {
                               // Apply the custom color once the view appears
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
                            .accentColor(.white) // Cursor color
                            .foregroundColor(.white)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                        
                        TextField("Expiry Date (MM/YY)", text: $expiryDate)
                            .accentColor(.white) // Cursor color
                            .foregroundColor(.white)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                            .foregroundColor(.white)
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
                    customerName: customerName,
                    address: address,
                    city: city,
                    postalCode: postalCode
                )) {
                    Text("Confirm Order")
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Sets text color to #BF387D
                        .cornerRadius(8)
                        .padding(.top, 20) // Padding for button
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
                    .font(.headline) // Customize the font if needed
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
                city: "Toronto",
                postalCode: "M5H 2N2"
            )
            .navigationBarTitle("Payment Options", displayMode: .inline)
        }
        .previewDevice("iPhone 14")
    }
}
