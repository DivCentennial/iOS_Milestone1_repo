//
//  CustomerInfoView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha on 2024-11-03.
//  Customer can input their personal data.
//// ....
import SwiftUI

struct CustomerInfoView: View {
    @State private var fullName = ""
    @State private var address = ""
    @State private var city = ""
    @State private var postalCode = ""
    @State private var phoneNumber = ""
    @State private var emailAddress = ""
    
    let brand: String
    let model: String
    let price: String
    let storage: String
    let color: String

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Customer Information")) {
                    TextField("Full Name", text: $fullName)
                    TextField("Street Address", text: $address)
                    TextField("City", text: $city)
                    TextField("Postal Code", text: $postalCode)
                    TextField("Phone Number", text: $phoneNumber)
                    TextField("Email Address", text: $emailAddress)
                }
            }

            NavigationLink(destination: PaymentOptionsView(
                brand: brand,
                model: model,
                price: price,
                storage: storage,
                color: color,
                customerName: fullName,
                address: address,
                city: city,
                postalCode: postalCode
                // Removed phoneNumber and emailAddress as parameters
            )) {
                Text("Proceed to Payment")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}
