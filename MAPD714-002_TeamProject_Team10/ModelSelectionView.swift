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
        ZStack {
            // Custom background color
            Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))
                .edgesIgnoringSafeArea(.all) // Extends the background to cover the entire screen
            
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
                
                // Checkout button outside the Form
                NavigationLink(destination: CheckoutView(
                    brand: selectedBrand,
                    model: selectedModel,
                    price: prices[selectedModel] ?? "N/A",
                    storage: selectedStorage,
                    color: selectedColor,
                    carrier: selectedCarrier
                )) {
                    Text("Checkout")
                        .frame(width: 200, height: 50)  // Fixed width and height
                        .background(Color.white)         // White background
                        .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Custom text color
                        .cornerRadius(8)                 // Rounded corners
                        .padding(.top, 20)               // Padding for spacing
                }
                .disabled(selectedModel.isEmpty)  // Disable if no model is selected
                .padding() // Optional: reduce bottom padding if needed
            }
        }
    }
}

// Preview for ModelSelectionView
struct ModelSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview with a sample brand, here it's "iPhone"
        ModelSelectionView(selectedBrand: "iPhone")
            .previewDevice("iPhone 14") // You can specify the device here
            .navigationBarTitle("Select Model", displayMode: .inline)
    }
}
