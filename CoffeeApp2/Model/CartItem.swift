//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//

import Foundation
import SwiftData

/// A persistent SwiftData schema model representing an individual line item inside the shopping cart.
@Model
class CartItem {
    
    /// A unique identifier for the specific cart item entry.
    var id = UUID()
    
    /// The associated coffee product details for this cart entry.
    /// Note: SwiftData automatically infers this as a model relationship.
    var coffee: Coffee
    
    /// The total count of this specific coffee item added to the cart.
    var quantity: Int
    
    /// Initializes a new instance of a `CartItem`.
    /// - Parameters:
    ///   - id: A unique identifier for the line item (defaults to a new UUID if not provided).
    ///   - coffee: The underlying `Coffee` model instance.
    ///   - quantity: The numerical count of the item.
    init(id: UUID = UUID(), coffee: Coffee, quantity: Int) {
        self.id = id
        self.coffee = coffee
        self.quantity = quantity
    }
}
