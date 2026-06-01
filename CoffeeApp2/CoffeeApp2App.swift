//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//


import SwiftUI
import SwiftData

/// The main entry point and configuration hub of the application.
/// It establishes global state lifecycle management and persistent storage structures.
@main
struct CoffeeApp2App: App {
    
    /// Establishes the single source of truth for the shopping cart's state lifecycle.
    /// Initialized as a `@StateObject` to ensure its persistence across view hierarchy updates.
    @StateObject private var cart = CartManager()
    
    // The underlying scene graph configuring the window rendering container
    var body: some Scene {
        WindowGroup {
            // The initial root view displayed to users when launching the application
            SplashView()
                // Injects the stateful cart manager instance globally down through the view hierarchy
                .environmentObject(cart)
        }
        // Attaches and provisions the database persistence container schema for the application's underlying data models
        .modelContainer(for: Coffee.self)
    }
}
