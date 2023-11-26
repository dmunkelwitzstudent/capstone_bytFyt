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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            LoginMenu()
        }
        .modelContainer(for: User.self)
    }
}
