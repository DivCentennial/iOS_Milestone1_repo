//
//  BrandSelectionView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
//
//This is where user selects brand.
// ....
import SwiftUI

struct BrandSelectionView: View {
    @State private var selectedBrand = "iPhone" // Default selection
    let brands = ["iPhone", "Samsung", "Google Pixel"]
    
    var body: some View {
        VStack {
            Picker("Select a Brand", selection: $selectedBrand) {
                ForEach(brands, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // Segmented control

            // Display the brand image based on selection
            Image(selectedBrand)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
            
            NavigationLink(destination: ModelSelectionView(selectedBrand: selectedBrand)) {
                Text("Next")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
        }
    }
}

