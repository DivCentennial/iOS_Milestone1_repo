//
//  ConfirmationView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha on 2024-11-03.
// User looks at the phone details b4 checkout
// ....
import SwiftUI

struct ConfirmationView: View {
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
        VStack(spacing: 20) {
            Text("Your phone order successfully completed!")
                .font(.title)
                .padding()

            List {
                Text("Brand: \(brand)")
                Text("Model: \(model)")
                Text("Price: \(price)")
                Text("Storage: \(storage)")
                Text("Color: \(color)")
                Text("Customer Name: \(customerName)")
                Text("Delivery Address: \(address), \(city), \(postalCode)")
            }
            
            Text("Thank you for your order!")
                .font(.headline)
        }
        .padding()
    }
}


