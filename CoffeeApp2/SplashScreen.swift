//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//

import SwiftUI

/// A view that presents an animated splash screen upon application launch,
/// handling the timed transition to the main dashboard interface.
struct SplashView: View {
    
    /// Controls the navigation routing state to switch between the splash layout and the main content.
    @State private var isActive = false
    
    /// Controls the scale factor of the central brand graphic icon to drive the pulsing animation.
    @State private var scale: CGFloat = 0.8
    
    // The declarative view hierarchy defining the splash layout and state routing logic
    var body: some View {
        
        if isActive {
            // Transitions to the primary dashboard once the onboarding timer elapses
            ContentView()
        } else {
            
            // Layered stack container establishing full-bleed branding backdrops
            ZStack {
                // Background flood fill aligned to brand guidelines
                Color.brown
                    .ignoresSafeArea() // Extends background coloration underneath device system status bars
                
                // Vertically tracks centered corporate logo graphics and structural text titles
                VStack(spacing: 20) {
                    
                    // Renders the scalable system vector asset representing the brand logo
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 80)) // Explicit sizing rule for standard icon clarity
                        .foregroundColor(.white)
                        .scaleEffect(scale) // Binds scale transforms directly to state variable transitions
                        .onAppear {
                            // Triggers a perpetual, breathing animation loop immediately upon visual mounting
                            withAnimation(
                                .easeInOut(duration: 1.2)
                                .repeatForever(autoreverses: true)
                            ) {
                                scale = 1.0 // Drives property modulation up to peak scale boundaries
                            }
                        }
                    
                    // Core app title branding element
                    Text("CoffeeApp ☕")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .onAppear {
                // Schedules an asynchronous context switch delaying main navigation by a fixed offset
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // Smoothly interpolates the structural state change using default animations
                    withAnimation {
                        isActive = true // Toggles routing state flag to dismantle the splash viewport
                    }
                }
            }
        }
    }
}

// Preview definition configuration to quickly validate layout changes inside the Xcode Canvas
#Preview {
    SplashView()
}
