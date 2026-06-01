//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//

import Foundation
import SwiftUI
import Combine
import SwiftData

/// Manages the state and business logic of the shopping cart,
/// allowing components across the app to observe changes dynamically.
class CartManager: ObservableObject {
    
    /// The collection of items currently in the cart, published to update SwiftUI views automatically.
    @Published var items: [CartItem] = []
    
    /// Adds a selected coffee item to the cart, increments quantity if it already exists.
    /// - Parameter coffee: The `Coffee` model instance to be added.
    func add(_ coffee: Coffee) {
        
        // Check if the item already exists in the cart based on its unique ID
        if let index = items.firstIndex(where: {
            $0.coffee.id == coffee.id
        }) {
            
            // If it exists, increment the quantity by 1
            items[index].quantity += 1
            
        } else {
            
            // If it's a new item, construct a new CartItem instance with an initial quantity of 1
            let newItem = CartItem(
                id: UUID(),
                coffee: coffee,
                quantity: 1
            )
            
            // Append the newly created item to the cart collection
            items.append(newItem)
        }
    }
    
    /// Removes items from the cart using an `IndexSet`, commonly utilized in SwiftUI list deletions.
    /// - Parameter offsets: The index indices tracking the positions of items to remove.
    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    /// Updates the specific quantity of a given cart item.
    /// - Parameters:
    ///   - item: The targeted `CartItem` whose quantity needs adjustments.
    ///   - quantity: The target total quantity count.
    func updateQuantity(
        for item: CartItem,
        quantity: Int
    ) {
        // Locate the index of the specific cart item matching the unique ID
        if let index = items.firstIndex(where: {
            $0.id == item.id
        }) {
            // Apply the new quantity value to the item in the array
            items[index].quantity = quantity
        }
    }
    
    /// A computed property that calculates the total cumulative price of all items currently in the cart.
    var total: Double {
        // Reduce the array down to a single total value, factoring in item unit price and quantity
        items.reduce(0) { total, item in
            
            total + (
                item.coffee.price *
                Double(item.quantity)
            )
        }
    }
}
