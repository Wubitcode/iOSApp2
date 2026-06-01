//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//

import Foundation

/**
 Fetches the static coffee menu dataset from the app bundle.
 
 - Note: This function fails gracefully by returning an empty array and logging
         errors to the console rather than throwing, preventing runtime crashes.
 */
func loadCoffeeData() -> [Coffee] {

    // Ensure the resource exists in the application bundle
    guard let url = Bundle.main.url(forResource: "coffeeData", withExtension: "json") else {
        print("JSON file not found")
        return []
    }

    do {
        // Synchronously load and decode the data payload
        let data = try Data(contentsOf: url)
        let decoderData = try JSONDecoder().decode([Coffee].self, from: data)

        print("Loaded \(decoderData.count) coffees")
        return decoderData

    } catch {
        // Fallback catch to handle potential decoding discrepancies or missing keys
        print("Error: \(error)")
        return []
    }
}
