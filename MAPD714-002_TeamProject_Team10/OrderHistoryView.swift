//
//  OrderHistoryView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2024-11-30.
//

import SwiftUI
import CoreData

struct OrderHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var orders: [Order] = [] // Store the orders for the user
    var username: String // Username of the logged-in user

    let primaryColor = Color(UIColor(red: 191/255, green: 56/255, blue: 125/255, alpha: 1.0)) // #BF387D Color

    var body: some View {
        ZStack {
            // Background color
            primaryColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Order History")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                if orders.isEmpty {
                    Text("No orders found.")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                } else {
                    List(orders, id: \.orderId) { order in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Order ID: \(order.orderId?.uuidString ?? "N/A")")
                                .font(.headline)
                            Text("Details: \(order.orderDetails ?? "No Details Available")")
                                .font(.subheadline)
                        }
                        .padding(.vertical, 4)
                    }
                    .frame(maxHeight: .infinity)
                }

                Spacer()
            }
            .padding()
        }
        .onAppear(perform: fetchOrderHistory)
        //.navigationBarTitle("Order History", displayMode: .inline)
    }

    private func fetchOrderHistory() {
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()

        // Fetch orders linked to the logged-in user
        fetchRequest.predicate = NSPredicate(format: "user.username == %@", username)

        do {
            let fetchedOrders = try viewContext.fetch(fetchRequest)
            self.orders = fetchedOrders
        } catch {
            print("Error fetching orders: \(error)")
        }
    }
}
 
