//
//  PaymentOptionsView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha on 2024-11-03.
// User selects payment method
// ....
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
        Form {
            Section(header: Text("Select Payment Method")) {
                Picker("Payment Method", selection: $selectedPaymentMethod) {
                    Text("Credit Card").tag("Credit Card")
                    Text("Debit Card").tag("Debit Card")
                    Text("Apple Pay / Google Pay").tag("Apple Pay / Google Pay")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
            }
            
            if selectedPaymentMethod == "Credit Card" || selectedPaymentMethod == "Debit Card" {
                Section(header: Text("Card Information")) {
                    TextField("Card Number", text: $cardNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Expiry Date (MM/YY)", text: $expiryDate)
                        .keyboardType(.numberPad)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
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
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
        .navigationBarTitle("Payment Options", displayMode: .inline)
    }
}


