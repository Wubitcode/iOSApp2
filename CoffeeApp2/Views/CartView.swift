//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//

import SwiftUI

/// A view that displays the shopping cart's contents, allowing users to modify quantities, delete items, and proceed to checkout.
struct CartView: View {
    
    /// The globally or hierarchically injected cart state manager.
    @EnvironmentObject var cart: CartManager
    
    // The declarative layout structure for the Cart user interface
    var body: some View {
        VStack {
            // Displays a scrollable list of all items currently in the shopping cart
            List {
                // Iterates over the array of published cart items to build individual row components
                ForEach(cart.items) { item in
                    VStack(alignment: .leading) {
                        // Horizontal container for the product title and its corresponding price
                        HStack {
                            Text(item.coffee.name)
                                .font(.headline)
                            
                            Spacer() // Pushes the price label out to the trailing edge
                            
                            // Displays formatted price up to two decimal places
                            Text("$\(item.coffee.price, specifier: "%.2f")")
                        }
                        
                        // A control for modifying the item quantity count within an allowed threshold (1 to 10)
                        Stepper(
                            // Creates a custom, bi-directional binding interface manually mapping
                            // the current item quantity value back to the underlying `CartManager` state logic.
                            value: Binding(
                                get: { item.quantity }, // Reads current model state
                                set: { cart.updateQuantity(for: item, quantity: $0) } // Mutates state via CartManager
                            ),
                            in: 1...10
                        ) {
                            Text("Quantity: \(item.quantity)")
                        }
                    }
                    .padding(.vertical, 4) // Adds comfortable structural breathing room inside rows
                }
                // Attaches native swipe-to-delete action handler linked directly to the cart's removal algorithm
                .onDelete(perform: cart.remove)
            }
            
            // Displays the aggregate total summary of all purchases in the cart
            Text("Total: $\(cart.total, specifier: "%.2f")")
                .font(.title2)
                .padding()
            
            // Primary call-to-action component to trigger processing pipelines
            Button("Checkout") {
                // Action block context stub for future order pipeline processing or routing
                print("Checkout tapped")
            }
            .frame(maxWidth: .infinity) // Stretches button width to match layout boundaries
            .padding()
            .background(Color.brown) // Corporate coffee-themed styling accent matching brand design
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding() // Exterior padding preventing edge flush artifact alignment issues
        }
        .navigationTitle("Your Cart") // Configures title visibility inside embedded NavigationStacks
    }
}

// Preview definition configuration to quickly validate layout changes inside the Xcode Canvas
#Preview {
    CartView()
        // Injects an empty, temporary mock instance of CartManager so the layout previews safely without crashing
        .environmentObject(CartManager())
}
