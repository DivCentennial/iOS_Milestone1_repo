//
//  CustomerInfoView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
//  Customer can input their personal data.
///
import SwiftUI

struct CustomerInfoView: View {
    @State private var fullName = ""
    @State private var address = ""
    @State private var city = ""
    @State private var postalCode = ""
    @State private var phoneNumber = ""
    @State private var emailAddress = ""
    
    let brand: String
    let model: String
    let price: String
    let storage: String
    let color: String

    var body: some View {
        VStack {
            
            Form {
                Section(header: Text("Customer Information"))
                {
                    TextField("Full Name", text: $fullName)
                       
                    TextField("Street Address", text: $address)
                       
                    TextField("City", text: $city)
                      
                    TextField("Postal Code", text: $postalCode)
                       
                    TextField("Phone Number", text: $phoneNumber)
                      
                    TextField("Email Address", text: $emailAddress)
                       
                }
            }
            .padding(.top, 40)
            .background(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Custom background color (#BF387D)

            NavigationLink(destination: PaymentOptionsView(
                brand: brand,
                model: model,
                price: price,
                storage: storage,
                color: color,
                customerName: fullName,
                address: address,
                city: city
                //postalCode: postalCode
                // Removed phoneNumber and emailAddress as parameters
            )) {
                Text("Proceed to Payment")
                    .frame(width: 200, height: 50)
                    .background(Color.white)
                    .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Sets text color to #BF387D
                    .cornerRadius(8)
                    .padding(.top, 20) // Padding for button
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))) // Custom background color (#BF387D)
            .edgesIgnoringSafeArea(.all) // Extend background to edges
        }
    }
}
// Preview for CustomerInfoView
struct CustomerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        // Providing example data for the preview
        CustomerInfoView(brand: "iPhone", model: "iPhone 14", price: "$799", storage: "128 GB", color: "Blue")
            .previewDevice("iPhone 14") // You can specify the device here
            .navigationBarTitle("Customer Info", displayMode: .inline)
    }
}
