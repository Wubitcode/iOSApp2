//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//

import SwiftUI
import SwiftData

/// A reusable component that renders a compact visual summary card for a coffee product,
/// including its image, description, price, and a quick-add action to the shopping cart.
struct CoffeeCardView: View {
    
    /// The immutable coffee product model data instance injected into this row or grid cell.
    let coffee: Coffee
    
    /// The shared cart instance used to dispatch user actions, such as adding this item to the active session.
    @EnvironmentObject var cart: CartManager
    
    // The declarative layout structure for the individual card interface
    var body: some View {
        
        // Vertically stacks the product media assets, typography elements, and interactive controls
        VStack(alignment: .leading) {
            
            // Assembles and formats the specific product item image asset
            Image(coffee.image)
                .resizable()
                .scaledToFit()
                .frame(height: 120) // Normalizes image height layout bounds uniform across lists/grids
                .clipped() // Ensures image bounding box overflows do not disrupt adjacent views
            
            // Primary label displaying the product's title
            Text(coffee.name)
                .font(.title3)
                .bold()
            
            // Subtitle metadata element describing flavor notes or origin attributes
            Text(coffee.coffeeDescription)
                .font(.subheadline)
                .foregroundStyle(.gray) // Secondary emphasis styling applied via modern ForegroundStyle API
            
            // Horizontal alignment track hosting commercial item economics and quick action triggers
            HStack {
                
                // Renders the currency localized value format representation mapping to two decimal places
                Text("$\(coffee.price, specifier: "%.2f")")
                    .font(.headline)
                
                Spacer() // Dispatches empty structural spacing to anchor layout elements to outer bounds
                
                // Call-to-action control allowing users to append this specific menu selection to their cart
                Button {
                    // Executes state mutation by forwarding the local entity record payload back to the coordinator
                    cart.add(coffee)
                } label: {
                    // Leverages SF Symbols system icons for scalable, modern graphic iconography vector assets
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.brown) // Semantic brand design system accent identifier coloration tracking
                }
            }
        }
        .padding() // Inner padding buffer ensuring elements are spaced appropriately from structural backdrops
        .background(Color(.systemBackground)) // Dynamically adaptive native background layer matching light/dark color schemes
        .cornerRadius(15) // Applies rounded edge framing structures mirroring standard iOS system aesthetic behaviors
        .shadow(radius: 5) // Injects depth hierarchy styling across interface layouts via subtle drop shadow rendering
    }
}

// Preview definition configuration to quickly validate layout changes inside the Xcode Canvas
#Preview {
    CoffeeCardView(
        // Passes standard static mock data to display during interactive testing sandboxes safely
        coffee: Coffee(
            id: "1",
            name: "Espresso",
            coffeeDescription: "Strong coffee",
            price: 2.99,
            image: "coffee",
            category: "Hot"
        )
    )
    // Feeds an empty mock manager down into the preview stack hierarchy to prevent application runtime failures
    .environmentObject(CartManager())
}
