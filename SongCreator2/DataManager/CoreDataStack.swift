//
//  CoreDataStack.swift
//  SongCreator2
//
//  Created by atillaemresöylemez on 24.09.2025.
//

import Foundation
import CoreData

// Define an observable class to encapsulate all Core Data-related functionality.
class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    // Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // Pass the data model filename to the container’s initializer.
        let container = NSPersistentContainer(name: "SongProjects")
        
        // Load any persistent stores, which creates a store if none exists.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // `fatalError(_:file:line:)` during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
        
    private init() { }
}


extension CoreDataStack {
    // Add a convenience method to commit changes to the store.
    func save() {
        // Verify that the context has uncommitted changes.
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            // Attempt to save changes.
            try persistentContainer.viewContext.save()
        } catch {
            // Handle the error appropriately.
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    func delete(item: SongModel) {
        persistentContainer.viewContext.delete(item)
        save()
    }
}
