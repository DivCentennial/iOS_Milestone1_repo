//
//  PaymentOptionsView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
//  User can select the payment method.

//
//  PaymentOptionsView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-03.
//  User can select the payment method.

import SwiftUI

struct PaymentOptionsView: View {
    @EnvironmentObject var authManager: AuthManager // Access AuthManager from the environment
    
    @State private var selectedPaymentMethod = ""
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    
    // Parameters received from CustomerInfoView
    let brand: String
    let model: String
    let price: String
    let storage: String
    let color: String
    let customerName: String
    let address: String
    let city: String
    
    @State private var navigateToConfirmation = false
    
    var body: some View {
        VStack {
            ZStack {
                Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0))
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Select Payment Method")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.top, 20)
                        .padding(.leading, 26)
                    
                    Picker("Payment Method", selection: $selectedPaymentMethod) {
                        Text("Credit Card").tag("Credit Card")
                        Text("Debit Card").tag("Debit Card")
                        Text("Apple Pay / Google Pay").tag("Apple Pay / Google Pay")
                    }
                    .padding(.top, 40)
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onAppear {
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 158/255, green: 47/255, blue: 102/255, alpha: 1.0)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                    }
                    
                    if selectedPaymentMethod == "Credit Card" || selectedPaymentMethod == "Debit Card" {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Card Information")
                                .foregroundColor(.white)
                                .font(.headline)
                            
                            TextField("Card Number (16 Digit)", text: $cardNumber)
                                .accentColor(.white)
                                .foregroundColor(.white)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                            
                            TextField("Expiry Date (MM/YY)", text: $expiryDate)
                                .accentColor(.white)
                                .foregroundColor(.white)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    Button(action: validateAndProceed) {
                        Text("Confirm Order")
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)))
                            .cornerRadius(8)
                            .padding(.top, 20)
                    }
                    .padding(.leading, 100)
                    .padding(.bottom, 20)
                    
                    // NavigationLink to ConfirmationView, activated when validation is successful
                    NavigationLink(
                        destination: ConfirmationView(
                            brand: brand,
                            model: model,
                            price: price,
                            storage: storage,
                            color: color,
                            customerName: authManager.currentUser?.fullname ?? "Unknown",
                            address: authManager.currentUser?.address ?? "No Address",
                            city: authManager.currentUser?.cityCountry ?? "No City"
                        ),
                        isActive: $navigateToConfirmation
                    ) {
                        EmptyView() // This is needed to make the navigation link work
                    }
                }
                .padding(.top)
            }
            .toast(isShowing: $showToast, message: toastMessage)
        }
        .navigationBarTitle("Payment Options", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Payment Options")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
    
    private func validateAndProceed() {
        if selectedPaymentMethod.isEmpty {
            showToast(message: "Please select a payment method.")
            return
        }
        
        if (selectedPaymentMethod == "Credit Card" || selectedPaymentMethod == "Debit Card") {
            if cardNumber.isEmpty || expiryDate.isEmpty {
                showToast(message: "Please fill in all card details.")
                return
            }
            if !isValidCardNumber(cardNumber) {
                showToast(message: "Card number must be exactly 16 digits.")
                return
            }
        }
        
        navigateToConfirmation = true // Trigger navigation
    }
    
    private func showToast(message: String) {
        toastMessage = message
        showToast = true
    }
    
    private func isValidCardNumber(_ cardNumber: String) -> Bool {
        let digitsOnly = cardNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        return digitsOnly.count == 16 && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: digitsOnly))
    }
}

// Toast Modifier
struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String

    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    Text(message)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.bottom, 50)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isShowing = false
                            }
                        }
                }
                .transition(.slide)
            }
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String) -> some View {
        self.modifier(ToastModifier(isShowing: isShowing, message: message))
    }
}
