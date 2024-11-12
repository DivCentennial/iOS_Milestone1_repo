//  CheckoutView.swift
//  MAPD714-002_TeamProject_Team10
//Checkout screen where user's selection is displayed
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
// Description: User can see the selected phone brand, model & features
import SwiftUI

struct CheckoutView: View {
    let brand: String
    let model: String
    let price: String
    let storage: String
    let color: String
    let carrier: String
    
    var body: some View {
        VStack(spacing: 15) {
//            Text("Checkout")
//                .font(.largeTitle)
//                .foregroundColor(.white)
//                .padding()
//Displays the selected phone features
            List {
                Text("Brand: \(brand)")
                Text("Model: \(model)")
                Text("Price: \(price)")
                Text("Storage: \(storage)")
                Text("Color: \(color)")
                Text("Carrier: \(carrier)")
            }
            
            NavigationLink(destination: CustomerInfoView(brand: brand, model: model, price: price, storage: storage, color: color)) {
                Text("Enter Customer Info")
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Sets text color to #BF387D
                    .cornerRadius(8)
                    .padding(.top, 20) // Padding for button
            }
        }
        .padding()
        .background(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Custom background color (#BF387D)
        .navigationBarTitle("Checkout", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Checkout")
                    .foregroundColor(.white)
                    .font(.headline) // Customize the font if needed
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(
            brand: "iPhone",
            model: "iPhone 15 Pro",
            price: "$999",
            storage: "256 GB",
            color: "Space Gray",
            carrier: "Verizon"
        )
        .previewDevice("iPhone 14") // Optional: specify device for preview
        .navigationBarTitle("Checkout", displayMode: .inline) // Optional: set title
    }
}

