//
//  CoffeeApp2App.swift
//  TimHorrtonsApp
//
//  Created by Admin on 2026-05-28.
//

import SwiftUI
import SwiftData

/// The primary dashboard view of the application that manages the coffee catalog,
/// providing dynamic category filtering, text searching, and persistent data seeding.
struct ContentView: View {
    
    /// Automatically fetches and keeps updated the collection of `Coffee` records from the persistent store.
    @Query private var coffees: [Coffee]
    
    /// Accesses the central SwiftData database context interface used for mutating and inserting records.
    @Environment(\.modelContext) private var context
    
    /// Tracks the live query string entered into the integrated system search bar component.
    @State private var searchText = ""
    
    /// Tracks the currently active menu segmentation category selection (defaulting to "All").
    @State private var selectedCategory = "All"
    
    /// Array containing the localized structural filter classifications available within the UI.
    let categories = ["All", "Hot", "Cold"]
    
    /// A computed collection that combines search queries and segmented selections to narrow down the active dataset.
    var filteredCoffee: [Coffee] {
        coffees.filter { coffee in
            // Match records against both the selected category rule and the case-insensitive search text query
            (selectedCategory == "All" || coffee.category == selectedCategory)
            &&
            (searchText.isEmpty ||
             coffee.name.lowercased().contains(searchText.lowercased()))
        }
    }
    
    // The declarative layout tree governing the interface hierarchy
    var body: some View {
        NavigationStack {
            VStack {
                // Informational counter logging the active database item counts
                Text("Coffee Count: \(coffees.count)")
                
                // Segmented picker UI widget allowing quick switching between item categories
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(.segmented) // Dictates a horizontal visual block representation layout
                .padding()
                
                // Scrollable container for presentation elements when content overflows standard constraints
                ScrollView {
                    // Optimized grid cell renderer initializing view matrices on demand for memory efficiency
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()), // Computes adaptive uniform split grid geometry sizing tracking columns
                            GridItem(.flexible())
                        ],
                        spacing: 15
                    ) {
                        // Dynamically generates cell wrappers binding downstream records to independent structural representations
                        ForEach(filteredCoffee) { coffee in
                            CoffeeCardView(coffee: coffee)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Coffee Menu ☕")
            .searchable(text: $searchText) // Modifies view structure to append a standard system search control field
            .toolbar {
                // Places an interactive routing hook targeting checkout stack transitions
                NavigationLink {
                    CartView()
                } label: {
                    Image(systemName: "cart")
                }
            }
            .onAppear {
                // Intercepts initial visual lifecycle triggers to determine database hydration requirements
                seedCoffeeDataIfNeeded()
            }
        }
    }
    
    /// Checks the persistent store status and initializes database records from local asset resources if empty.
    func seedCoffeeDataIfNeeded() {
        // Halt processing execution streams immediately if data counts demonstrate state has already seeded
        guard coffees.isEmpty else { return }
        
        // De-serialize standard structural reference catalogs out of localized asset stores
        let sampleCoffees = loadCoffeeData()
        
        // Loop through records array payloads writing entity objects into active context registers
        for coffee in sampleCoffees {
            context.insert(coffee)
        }
        
        // Debug confirmation console trace indicating changes are registered within active contexts
        print("Inserted \(sampleCoffees.count) coffees into SwiftData")
    }
}

// Preview definition configurations managing sandboxed workspace setups safely
#Preview {
    ContentView()
        // Configures environment dependencies to prevent view parsing crashes during visual preview simulations
        .environmentObject(CartManager())
        // Provisions a isolated database memory architecture so tests do not impact physical user production databases
        .modelContainer(for: Coffee.self, inMemory: true)
}
