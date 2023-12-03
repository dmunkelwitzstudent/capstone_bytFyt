//
//  bytFyt_capstoneApp.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/1/23.
//

import SwiftUI
import SwiftData

@main
struct bytFyt_capstoneApp: App {
    
    @Environment(\.modelContext) private var modelContext
    @Query var users: [User]
    @Query var exercises: [Exercise]
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
            Workout.self,
            Exercise.self,
            Entry.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {

                ContentView()

        }
        .modelContainer(for: [User.self, Workout.self, Entry.self, Exercise.self])
    }
}
