//  CheckoutView.swift
//  MAPD714-002_TeamProject_Team10
//Checkout screen where user's selection is displayed
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
// Description: User can see the selected phone brand, model & features
import SwiftUI
import CoreData

struct CheckoutView: View {
    @Environment(\.phoneContext) private var phoneContext // Access Core Data context
    var selectedPhone: PhoneData // The selected phone passed as a parameter

    var body: some View {
        VStack(spacing: 15) {
            // Display the selected phone details
            List {
                Text("Brand: \(selectedPhone.phoneBrand ?? "N/A")")
                Text("Model: \(selectedPhone.phoneModel ?? "N/A")")
                Text("Price: \(selectedPhone.phonePrice ?? "N/A")")
                Text("Storage: \(selectedPhone.phoneStorage ?? "N/A")")
                Text("Color: \(selectedPhone.phoneColor ?? "N/A")")
                Text("Carrier: \(selectedPhone.phoneCarrier ?? "N/A")")
            }

            // Navigate to Payment Options View, passing the phone data
            NavigationLink(destination: PaymentOptionsView(
                brand: selectedPhone.phoneBrand ?? "N/A",
                model: selectedPhone.phoneModel ?? "N/A",
                price: selectedPhone.phonePrice ?? "N/A",
                storage: selectedPhone.phoneStorage ?? "N/A",
                color: selectedPhone.phoneColor ?? "N/A",
                customerName: "", // Placeholder, add real data if needed
                address: "",      // Placeholder
                city: ""        // Placeholder
               // postalCode: ""    // Placeholder
            )) {
                Text("Proceed to Payment")
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0))) // Sets text color to #BF387D
                    .cornerRadius(8)
                    .padding(.top, 20) // Padding for button
            }
        }
        .padding()
        .background(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0))) // Custom background color (#BF387D)
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

// Preview for CheckoutView
struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PhonePersistenceController.preview.container.viewContext
        let examplePhone = PhoneData(context: previewContext)
        examplePhone.productId = UUID()
        examplePhone.phoneBrand = "iPhone"
        examplePhone.phoneModel = "iPhone 15 Pro"
        examplePhone.phonePrice = "$999"
        examplePhone.phoneStorage = "256 GB"
        examplePhone.phoneColor = "Space Gray"
        examplePhone.phoneCarrier = "Verizon"

        return NavigationView {
            CheckoutView(selectedPhone: examplePhone)
                .environment(\.phoneContext, previewContext)
        }
    }
}
