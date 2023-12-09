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
    @Query var entries: [Entry]
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
            Workout.self,
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
                .onAppear {
                    
                    if (!users.isEmpty && !entries.isEmpty) {
                        
                        var main = users[0];
                        
                        let calendar = Calendar.current;

                        let components = calendar.dateComponents([.day], from: entries[entries.count - 1].Date, to: Date());

                        var daysSinceLastLogin = components.day! - 1;

                        
                        

                        while (daysSinceLastLogin != 0) {
                            
                            var newEntry = Entry(today: Date() - (86400 * Double(daysSinceLastLogin)), weight: main.currentWeight, sleep: main.currentSleep, foodCalories: main.currentFoodCalories, water: main.currentWater, sleepQuality: main.currentSleepQuality, activeCalories: main.currentActiveCalories);
                            
                            
                            
                        
                            modelContext.insert(newEntry);
                            main.resetCurrentVariables();
                            
                            
                            
                            daysSinceLastLogin -= 1;
                        }
                    }

                }
            
            

        }
        .modelContainer(for: [User.self, Workout.self, Entry.self])
    }
}
