//
//  ConfirmationView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
// User looks at the phone details b4 checkout
//
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
            Text("Your phone order is successfully completed!🥳")
                .font(.system(size: 17)) // Custom font size
                .padding(.top, 80) // Adds 40 points of space at the top
                .foregroundColor(.white) // White text color

            List {
                Text("Brand: \(brand)")
                    .padding(.vertical, 20) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) //coloring rows
                Text("Model: \(model)")
                    .padding(.vertical, 20) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                
                Text("Price: \(price)")
                    .padding(.vertical, 20) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                
                Text("Storage: \(storage)")
                    .padding(.vertical, 20) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                       
                Text("Color: \(color)")
                    .padding(.vertical, 20) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                      
                Text("Customer Name: \(customerName)")
                    .padding(.vertical, 20) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                       
                Text("Delivery Address: \(address), \(city), \(postalCode)")
                    .padding(.vertical, 20) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                       
            }
        
            Text("Thank you for your order! 🤩")
                .font(.headline)
                .foregroundColor(.white) // Change text color to white
        }
        .padding()
        .background(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Custom background color (#BF387D)
        .edgesIgnoringSafeArea(.all) // Extend background to edges
    }
}

// Preview for ConfirmationView
struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        // Providing example data for the preview
        ConfirmationView(
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
        .previewDevice("iPhone 14") // You can specify the device here
        .navigationBarTitle("Confirmation", displayMode: .inline)
    }
}
