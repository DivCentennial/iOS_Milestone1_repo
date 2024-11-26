//
//  BrandSelectionView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
//
//This is where user selects brand.
// Description: User may select the desired brand among apple samsung & //google pixel
import SwiftUI

struct BrandSelectionView: View {
    @Environment(\.phoneContext) private var phoneContext // Access PhoneData context
    @State private var selectedBrand = "iPhone" // Default selection
    let brands = ["iPhone", "Samsung", "Google Pixel"]

    // Computed property to get the correct image name based on selected brand
    private var brandImageName: String {
        switch selectedBrand {
        case "iPhone":
            return "iphone_image" // Match the name in your asset catalog
        case "Samsung":
            return "samsung_image"
        case "Google Pixel":
            return "pixel_image"
        default:
            return "placeholder_image" // Optional: a default image if needed
        }
    }

    var body: some View {
        VStack {
            // Display the brand image based on the computed property
            Image(brandImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.top, 10) // Reduced space above the image

            // Picker for selecting brand
            Picker("Select a Brand", selection: $selectedBrand) {
                ForEach(brands, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) // Segmented control
            .padding([.horizontal, .top], 10) // Adjusted padding for the picker
            .onAppear {
                // Apply the custom color once the view appears
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 158 / 255, green: 47 / 255, blue: 102 / 255, alpha: 1.0)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
            }

            // Save button to persist selected brand to Core Data
            Button(action: saveSelectedBrand) {
                Text("Save and Continue")
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0)))
                    .cornerRadius(8)
                    .padding(.top, 20)
            }

            // Navigation link to the next view
            NavigationLink(destination: ModelSelectionView(selectedBrand: selectedBrand)) {
                Text("Next")
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0))) // Sets text color to #BF387D
                    .cornerRadius(8)
                    .padding(.top, 20) // Padding for button
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Makes the VStack take the full screen
        .background(Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0))) // Sets background to #BF387D
        .edgesIgnoringSafeArea(.all) // To extend the background color to edges
        .navigationBarTitle("Select Brand", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select Brand")
                    .foregroundColor(.white)
                    .font(.headline) // Customize the font if needed
            }
        }
    }

    // Function to save the selected brand to Core Data
    private func saveSelectedBrand() {
        let newPhoneData = PhoneData(context: phoneContext)
        newPhoneData.productId = UUID()
        newPhoneData.phoneBrand = selectedBrand

        do {
            try phoneContext.save()
            print("Brand saved successfully: \(selectedBrand)")
        } catch {
            print("Failed to save selected brand: \(error)")
        }
    }
}

struct BrandSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BrandSelectionView()
            .environment(\.phoneContext, PhonePersistenceController.preview.container.viewContext)
    }
}
