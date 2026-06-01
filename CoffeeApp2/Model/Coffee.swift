//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//

import Foundation
import SwiftData

/// A persistent SwiftData schema model that represents a coffee product,
/// supporting both database persistence and JSON decoding/encoding.
@Model
class Coffee: Codable {
    
    /// The unique identifier mapping to the database primary key and JSON ID field.
    var id: String
    
    /// The display name of the coffee product.
    var name: String
    
    /// A descriptive overview detailing the blend, flavor notes, or origin.
    var coffeeDescription: String
    
    /// The base retail cost of the product.
    var price: Double
    
    /// A string reference key or local asset name for rendering the product's image.
    var image: String
    
    /// The classification grouping (e.g., "Espresso", "Cold Brew") for sorting and filtering.
    var category: String
    
    /// Initializes a new instance of a `Coffee` object manually.
    /// - Parameters:
    ///   - id: The unique string identifier.
    ///   - name: The name of the coffee.
    ///   - coffeeDescription: A description of the coffee blend.
    ///   - price: The purchase price.
    ///   - image: The image resource name or URL string.
    ///   - category: The catalog categorization filter.
    init(
        id: String,
        name: String,
        coffeeDescription: String,
        price: Double,
        image: String,
        category: String
    ) {
        self.id = id
        self.name = name
        self.coffeeDescription = coffeeDescription
        self.price = price
        self.image = image
        self.category = category
    }
    
    /// Coding keys to map Swift property names to structural JSON payload keys during serialization.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coffeeDescription
        case price
        case image
        case category
    }
      
    /// Decodes a `Coffee` instance from an external JSON data payload.
    /// - Parameter decoder: The decoder interface driving the deserialization process.
    /// - Throws: A decoding error if any required properties are missing or corrupted.
    required init(from decoder: Decoder) throws {
        // Access the top-level container keyed by our local enum map
        let container = try decoder.container(keyedBy: CodingKeys.self)
          
        // Explicitly extract property values to satisfy both Codable and SwiftData requirements
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        coffeeDescription = try container.decode(String.self, forKey: .coffeeDescription)
        price = try container.decode(Double.self, forKey: .price)
        image = try container.decode(String.self, forKey: .image)
        category = try container.decode(String.self, forKey: .category)
    }
      
    /// Encodes this `Coffee` instance out to an external target data payload.
    /// - Parameter encoder: The encoder interface driving the serialization process.
    /// - Throws: An encoding error if structural serialization fails.
    func encode(to encoder: Encoder) throws {
        // Establish an external-facing container keyed by our local enum map
        var container = encoder.container(keyedBy: CodingKeys.self)
          
        // Explicitly map properties back to the data container output
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(coffeeDescription, forKey: .coffeeDescription)
        try container.encode(price, forKey: .price)
        try container.encode(image, forKey: .image)
        try container.encode(category, forKey: .category)
    }
}
