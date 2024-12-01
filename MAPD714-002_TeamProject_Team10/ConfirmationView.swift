//
//  ConfirmationView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
// User looks at the phone details and the personal details at the end.
//
import SwiftUI
import CoreData

struct ConfirmationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var authManager: AuthManager // Replace with your actual auth manager
    @State private var showToastMessage: String?
    
    let brand: String
    let model: String
    let price: String
    let storage: String
    let color: String
    let customerName: String
    let address: String
    let city: String
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Your phone order is successfully completed!🥳")
                .font(.system(size: 17)) // Custom font size
                .padding(.top, 10) // Adds 10 points of space at the top
                .foregroundColor(.white) // White text color

            List {
                Text("Brand: \(brand)")
                    .padding(.vertical, 5) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Coloring rows
                Text("Model: \(model)")
                    .padding(.vertical, 5) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                Text("Price: \(price)")
                    .padding(.vertical, 5) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                Text("Storage: \(storage)")
                    .padding(.vertical, 5) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                Text("Color: \(color)")
                    .padding(.vertical, 5) // Increase vertical padding
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                Text("Customer Name: \(customerName)")
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                Text("Delivery Address: \(address), \(city)")
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
            }

            Button(action: saveOrder) {
                Text("Save Order")
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                    .cornerRadius(8)
            }
            .padding(.top, 20)

            Text("Thank you for your order! 🤩")
                .font(.headline)
                .foregroundColor(.white) // Change text color to white
        }
        .padding()
        .background(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Custom background color (#BF387D)
        //.edgesIgnoringSafeArea(.all) // Extend background to edges
        //.edgesIgnoringSafeArea(.all) // Extend background to edges
        .toast(message: showToastMessage, isShowing: $showToastMessage.wrappedValue != nil)
    }

    private func saveOrder() {
        guard let currentUser = authManager.currentUser else {
            showToastMessage = "No user logged in."
            return
        }

        let newOrder = NSEntityDescription.insertNewObject(forEntityName: "Order", into: viewContext)
        
        // Set the order details and orderId
        newOrder.setValue(UUID(), forKey: "orderId")
        newOrder.setValue("""
        Customer: \(customerName)
        Address: \(address), \(city)
        Phone: \(brand) \(model)
        Price: \(price)
        Storage: \(storage)
        Color: \(color)
        Date: \(Date().formatted())
        """, forKey: "orderDetails")
        
        // Associate the order with the current user
        newOrder.setValue(currentUser, forKey: "user")

        do {
            try viewContext.save()
            showToastMessage = "Order saved successfully!"
        } catch {
            showToastMessage = "Failed to save order. Please try again."
            print("Error saving order: \(error.localizedDescription)")
        }
    }
}

// Toast Modifier
extension View {
    func toast(message: String?, isShowing: Bool) -> some View {
        ZStack {
            self
            if isShowing, let message = message {
                VStack {
                    Text(message)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(8)
                        .padding(.top, 50)
                    Spacer()
                }
                .transition(.opacity)
                .animation(.easeInOut, value: isShowing)
            }
        }
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
            city: "Toronto, Canada"
            //postalCode: "M5H 2N2"
        )
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(AuthManager()) // Replace with your auth manager preview
    }
}
