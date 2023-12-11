//
//  BytFytApp.swift
//  BytFyt
//
//  Created by Daniel Munkelwitz on 12/10/23.
//

import SwiftUI
import SwiftData

@main
struct BytFytApp: App {
    @Environment(\.modelContext) private var modelContext;
    @Query var users: [User];
    @Query var entries: [Entry];
    
    var sharedModelContainer: ModelContainer = {
        // Classes to be stored in model container
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
                        
                        let main = users[0];
                        
                        // this code checks how many days it has been since the last login.
                        // for example, the last login was on 12/04 and today is 12/10
                        // this would be 5 days between the days.
                        
                        let calendar = Calendar.current;
                        
                        let components = calendar.dateComponents([.day], from: entries[entries.count - 1].Date, to: Date());
                        
                        var daysSinceLastLogin = components.day! - 1;
                        
                        // the while loop will add Entry objects into the database.
                        // working by multiplying 86400 (total seconds in a day)  by the day counter
                        // so the code will start at the day after the last entries day, then push an Entry object to represent each day,
                        // stopping before the current day, since we shouldn't push an Entry that represents today, until the day has changed.
                        
                        while (daysSinceLastLogin != 0) {
                            // For this example, var should be used as this is a while loop, and the value will be changed.
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
