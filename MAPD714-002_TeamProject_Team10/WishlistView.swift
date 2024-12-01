//
//  WishlistView.swift
//  MAPD714-002_TeamProject_Team10
//
//  Created by Divyanshoo Sinha on 2024-11-30.
//


import SwiftUI
import CoreData

struct WishlistView: View {
    
    @FetchRequest(
        entity: WishlistItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \WishlistItem.itemName, ascending: true)]
    ) var wishlistItems: FetchedResults<WishlistItem>
    
    @Environment(\.managedObjectContext) private var context // Access Core Data context

    // Function to delete an item from Core Data
    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = wishlistItems[index]
            context.delete(item) // Delete the item from the context
        }
        
        // Save the changes to Core Data
        do {
            try context.save()
        } catch {
            print("Failed to delete item: \(error)")
        }
    }
        
    var body: some View {
        NavigationView {
            ZStack { // Apply background color to the ZStack
                Color(UIColor(red: 191 / 255, green: 56 / 255, blue: 125 / 255, alpha: 1.0))
                    .edgesIgnoringSafeArea(.all) // Covers the entire view except navigation

                VStack(spacing: 0) {
                    if wishlistItems.isEmpty {
                        Text("No items in Wishlist")
                            .foregroundColor(.white)
                            .font(.headline)
                    } else {
                        List {
                            ForEach(wishlistItems, id: \.id) { item in
                                VStack(alignment: .leading) {
                                    Text(item.itemName ?? "Unknown Item")
                                        .font(.headline)
                                    Text(item.itemBrand ?? "Unknown Brand")
                                        .font(.subheadline)
                                }
                            }
                            .onDelete(perform: deleteItem) // Enable swipe-to-delete
                        }
                        .listStyle(InsetGroupedListStyle()) // Optional for styling
                        .background(Color.clear) // Prevents background interference
                    }
                }
                .padding()
            }
            .navigationTitle("Wishlist")
            .toolbar {
                // Add an EditButton for toggling list editing
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
}
