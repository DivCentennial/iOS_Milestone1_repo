//  CheckoutView.swift
//  MAPD714-002_TeamProject_Team10
//Checkout screen where user's selection is displayed
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
// Description: User can see the selected phone brand, model & features
import SwiftUI
import CoreData

struct CheckoutView: View {
    @Environment(\.phoneContext) private var phoneContext // Access Core Data context
    var selectedPhone: Phone // The selected phone passed as a parameter

    // Function to add the selected phone to the wishlist
    func addToWishlist() {
        // Create a new WishlistItem entity in Core Data
        let wishlistItem = WishlistItem(context: phoneContext)
        wishlistItem.id = UUID() // Unique ID
        wishlistItem.itemName = selectedPhone.phoneModel
        wishlistItem.itemBrand = selectedPhone.phoneBrand
        wishlistItem.phoneColor = selectedPhone.phoneColor
        wishlistItem.price = selectedPhone.price
        wishlistItem.storageCapacity = selectedPhone.storageCapacity
        
        // Save the context
        do {
            try phoneContext.save()
            print("Item added to wishlist!")
        } catch {
            print("Failed to save to wishlist: \(error)")
        }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            // Display the selected phone details
            List {
                Text("Brand: \(selectedPhone.phoneBrand ?? "N/A")")
                Text("Model: \(selectedPhone.phoneModel ?? "N/A")")
                Text("Price: \(selectedPhone.price ?? "N/A")")
                Text("Storage: \(selectedPhone.storageCapacity ?? "N/A")")
                Text("Color: \(selectedPhone.phoneColor ?? "N/A")")
                Text("Carrier: \(selectedPhone.carrier ?? "N/A")")
            }
            .onAppear {
                        print("selectedPhone in CheckoutView: \(selectedPhone)")
                    }
            
            // Button to add the phone to the wishlist
            Button(action: {
                addToWishlist() // Add to wishlist
            }) {
                Text("Add to Wishlist")
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0)))
                    .cornerRadius(8)
                    .padding(.top, 20)
            }
            
            // Navigate to Wishlist View
            NavigationLink(destination: WishlistView()) {
                Text("View Wishlist")
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0)))
                    .cornerRadius(8)
                    .padding(.top, 20)
            }

            // Navigate to Payment Options View
            NavigationLink(destination: PaymentOptionsView(
                brand: selectedPhone.phoneBrand ?? "N/A",
                model: selectedPhone.phoneModel ?? "N/A",
                price: selectedPhone.price ?? "N/A",
                storage: selectedPhone.storageCapacity ?? "N/A",
                color: selectedPhone.phoneColor ?? "N/A",
                customerName: "", // Placeholder, add real data if needed
                address: "",      // Placeholder
                city: ""        // Placeholder
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
