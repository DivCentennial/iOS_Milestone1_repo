//Checkout screen where user's selection is displayed
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
// ...
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
            Text("Checkout")
                .font(.largeTitle)
                .padding()

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
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

