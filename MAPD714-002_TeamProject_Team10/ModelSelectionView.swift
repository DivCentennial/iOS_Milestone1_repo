//
//  ModelSelectionView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
//
//This is where user selects brand.
// Description: User can select model based on the selected brand

import SwiftUI
import CoreData

struct ModelSelectionView: View {
    let selectedBrand: String
    @Environment(\.phoneContext) private var phoneContext // Access Core Data context for PhoneData
    @State private var selectedModel = ""
    @State private var selectedStorage = "64 GB"
    @State private var selectedColor = "Blue"
    @State private var selectedCarrier = "Bell"
    
    // State to hold selected phone data
    @State private var selectedPhone: Phone? = nil

    // Array of models
    let models = [
        "iPhone": ["iPhone 14", "iPhone 15", "iPhone 15 Pro", "iPhone 15 Pro Max"],
        "Samsung": ["Galaxy S23", "Galaxy Z Fold 5", "Galaxy Z Fold 6", "Galaxy S23 Ultra"],
        "Google Pixel": ["Google Pixel 9", "Google Pixel 9 Pro", "Google Pixel 8", "Google Pixel 8 Pro"]
    ]
    
    // Array of prices
    let prices = [
        "iPhone 14": "$799", "iPhone 15": "$899", "iPhone 15 Pro": "$999", "iPhone 15 Pro Max": "$1099",
        "Galaxy S23": "$849", "Galaxy Z Fold 5": "$1799", "Galaxy Z Fold 6": "$1899", "Galaxy S23 Ultra": "$1199",
        "Google Pixel 9": "$699", "Google Pixel 9 Pro": "$899", "Google Pixel 8": "$599", "Google Pixel 8 Pro": "$799"
    ]
    
    // Array of features
    let storages = ["64 GB", "128 GB", "256 GB"]
    let colors = ["Blue", "Black", "Silver"]
    let carriers = ["Bell", "Rogers", "Telus"]

    var body: some View {
        ZStack {
            // Custom background color
            Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0))
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Form with limited height
                Form {
                    Section(header: Text("Select Model")) {
                        Picker("Model", selection: $selectedModel) {
                            ForEach(models[selectedBrand] ?? [], id: \.self) {
                                Text($0)
                            }
                        }
                        if let price = prices[selectedModel] {
                            Text("Price: \(price)")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    Section(header: Text("Select Storage")) {
                        Picker("Storage", selection: $selectedStorage) {
                            ForEach(storages, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section(header: Text("Select Color")) {
                        Picker("Color", selection: $selectedColor) {
                            ForEach(colors, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section(header: Text("Select Carrier")) {
                        Picker("Carrier", selection: $selectedCarrier) {
                            ForEach(carriers, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                .frame(maxHeight: 450) // Limiting the height of the Form

                // Save and Checkout button
                Button(action: savePhoneDetails) {
                    Text("Save")
                        .frame(width: 200, height: 50)  // Fixed width and height
                        .background(Color.white)         // White background
                        .foregroundColor(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0))) // Custom text color
                        .cornerRadius(8)                 // Rounded corners
                        .padding(.top, 20)               // Padding for spacing
                }
                .disabled(selectedModel.isEmpty) // Disable if no model is selected

                NavigationLink(destination: CheckoutView(selectedPhone: selectedPhone ?? Phone(context: phoneContext))) {
                    Text("Proceed to Checkout")
                        .frame(width: 200, height: 50)
                        .background(Color.white)
                        .foregroundColor(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0)))
                        .cornerRadius(8)
                        .padding(.top, 10)
                }
                .disabled(selectedModel.isEmpty) // Disable if no model is selected
                .padding()
            }
        }
        .onAppear {
            phoneContext.refreshAllObjects() // Refresh all objects
            selectedPhone = fetchPhoneData() // Fetch phone data and assign to selectedPhone state
            print("selectedPhone in onAppear: \(String(describing: selectedPhone))")
        }
        .onDisappear {
            // Save the context when the view disappears
            do {
                try phoneContext.save()
                print("Context saved successfully")
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }

    // Save selected details to Core Data
    private func savePhoneDetails() {
        let fetchRequest: NSFetchRequest<Phone> = Phone.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "phoneModel == %@ AND phoneBrand == %@", selectedModel, selectedBrand)
        
        do {
            let result = try phoneContext.fetch(fetchRequest)
            
            if let existingPhoneData = result.first {
                // Update the existing phone data
                existingPhoneData.phoneModel = selectedModel
                existingPhoneData.phoneColor = selectedColor
                existingPhoneData.storageCapacity = selectedStorage
                existingPhoneData.carrier = selectedCarrier
                existingPhoneData.price = prices[selectedModel] ?? "N/A"
                
                try phoneContext.save()
                print("Phone details updated successfully: \(existingPhoneData)")

                // After saving, set the selectedPhone state
                selectedPhone = existingPhoneData
            } else {
                // Create a new phone data object
                let newPhoneData = Phone(context: phoneContext)
                newPhoneData.productId = UUID()
                newPhoneData.phoneBrand = selectedBrand
                newPhoneData.phoneModel = selectedModel
                newPhoneData.phoneColor = selectedColor
                newPhoneData.storageCapacity = selectedStorage
                newPhoneData.price = prices[selectedModel] ?? "N/A"
                newPhoneData.carrier = selectedCarrier
                
                try phoneContext.save()
                print("New phone details saved successfully: \(newPhoneData)")

                // After saving, set the selectedPhone state
                selectedPhone = newPhoneData
            }
        } catch {
            print("Failed to save phone details: \(error)")
        }
    }


    // Fetch the phone data from Core Data for the checkout
    private func fetchPhoneData() -> Phone? {
        let fetchRequest: NSFetchRequest<Phone> = Phone.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "phoneModel == %@ AND phoneBrand == %@", selectedModel, selectedBrand)
        
        do {
            let result = try phoneContext.fetch(fetchRequest)
            if let phone = result.first {
                print("Fetched phone: \(phone)") // Debugging print
                return phone
            } else {
                print("No matching phone found in Core Data")
                return nil // Return nil if no matching phone is found
            }
        } catch {
            print("Error fetching phone data: \(error)")
            return nil // Return nil in case of error
        }
    }
}

struct ModelSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ModelSelectionView(selectedBrand: "iPhone")
            .environment(\.phoneContext, PersistenceController.preview.container.viewContext)
    }
}
