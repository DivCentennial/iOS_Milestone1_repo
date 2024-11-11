//User can select the models.
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
// ....// ....
import SwiftUI

struct ModelSelectionView: View {
    let selectedBrand: String
    @State private var selectedModel = ""
    @State private var selectedStorage = "64 GB"
    @State private var selectedColor = "Blue"
    @State private var selectedCarrier = "Bell"
    
    let models = [
        "iPhone": ["iPhone 14", "iPhone 15", "iPhone 15 Pro", "iPhone 15 Pro Max"],
        "Samsung": ["Galaxy S23", "Galaxy Z Fold 5", "Galaxy Z Fold 6", "Galaxy S23 Ultra"],
        "Google Pixel": ["Google Pixel 9", "Google Pixel 9 Pro", "Google Pixel 8", "Google Pixel 8 Pro"]
    ]
    
    let prices = [
        "iPhone 14": "$799", "iPhone 15": "$899", "iPhone 15 Pro": "$999", "iPhone 15 Pro Max": "$1099",
        "Galaxy S23": "$849", "Galaxy Z Fold 5": "$1799", "Galaxy Z Fold 6": "$1899", "Galaxy S23 Ultra": "$1199",
        "Google Pixel 9": "$699", "Google Pixel 9 Pro": "$899", "Google Pixel 8": "$599", "Google Pixel 8 Pro": "$799"
    ]
    
    let storages = ["64 GB", "128 GB", "256 GB"]
    let colors = ["Blue", "Black", "Silver"]
    let carriers = ["Bell", "Rogers", "Telus"]
    
    var body: some View {
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
                        .foregroundColor(.gray)
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
            
            NavigationLink(destination: CheckoutView(
                brand: selectedBrand,
                model: selectedModel,
                price: prices[selectedModel] ?? "N/A",
                storage: selectedStorage,
                color: selectedColor,
                carrier: selectedCarrier
            )) {
                Text("Checkout")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .disabled(selectedModel.isEmpty) // Disable if no model is selected
        }
    }
}

