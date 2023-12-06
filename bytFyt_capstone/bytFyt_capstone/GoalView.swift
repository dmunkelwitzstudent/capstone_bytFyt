//
//  GoalView.swift
//  bytFyt_capstone
//
//  Created by Steffens, Nick on 12/4/23.
//

import SwiftUI
import SwiftData

struct GoalView: View {
    
    
    
    
    //Color scheme for GoalView
    struct AppColorScheme {
        static let backgroundColor = Color.blue
        static let accentColor = Color.white
        static let textColor = Color.white
    }
    
    // State variables to store text input
    @Environment(\.modelContext) private var modelContext
    @Query var users: [User];
    @State private var sleepGoalInput: String = ""
    @State private var waterGoalInput: String = ""
    @State private var calorieGoalInput: String = ""
    @State private var caloriesBurntInput: String = ""
    @State private var showingSleepAlert = false
    @State private var showingWaterAlert = false
    @State private var showingCalorieAlert = false
    @State private var showingActivityAlert = false
    
    var body: some View {
        var main = users[0]
        ZStack {
            AppColorScheme.accentColor
                .ignoresSafeArea(edges: .all)
            
            VStack {
                
                // Dashboard Header'
                Text("\(main.FirstName)'s goals")
                //Applies styles to the views. Try to keep consistent!
                    .font(.largeTitle)
                    .foregroundColor(AppColorScheme.backgroundColor)
                    .padding()
                
                // Sleep goal editing
                HStack {
                    VStack {
                        HStack {
                            Text("Current sleep goal: \(main.SleepGoal.formatted()) hours per night")
                        }
                        HStack {
                            TextField("Enter sleep goal", text: $sleepGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                            
                            Button("Set Goal") {
                                // Convert input to Double and update sleep goal
                                if (Double(sleepGoalInput) ?? 0 > 24 || Double(sleepGoalInput) ?? 0 < 1) {
                                    showingSleepAlert = true
                                }
                                else if let newGoal = Double(sleepGoalInput) {
                                    main.SleepGoal = newGoal
                                }
                                sleepGoalInput = ""
                                
                                
                            }.alert("Please enter a value between 1 and 24 hours", isPresented: $showingSleepAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        }
                    }
                    
                }
                .padding()
                
                
                // Water goal
                HStack {
                    VStack {
                        Text("Current water goal: \(main.WaterGoal.formatted()) ounces a day")
                        HStack {
                            TextField("Enter water goal", text: $waterGoalInput)
                                .textFieldStyle(PlainTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                
                            
                            Button("Set Goal") {
                                if (Double(waterGoalInput) ?? 0 > 1000 || Double(waterGoalInput) ?? 0 < 100) {
                                    showingWaterAlert = true
                                }
                                // Convert input to Double and update water goal
                                else if let newGoal = Double(waterGoalInput) {
                                    main.WaterGoal = newGoal
                                }
                                waterGoalInput = ""
                            }.alert("Please enter a value between 100 and 1000 ounces", isPresented: $showingWaterAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        }
                    }
                }
                .padding()
                
                // Calorie goal
                HStack {
                    VStack {
                        Text("Current calorie goal: \(main.CalorieGoal.formatted()) calories a day")
                        HStack {
                            TextField("Enter calorie goal", text: $calorieGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                
                            Button("Set Goal") {
                                if (Double(calorieGoalInput) ?? 0 < 0) {
                                    showingCalorieAlert = true
                                }
                                // Convert input to Double and update calorie goal
                                else if let newGoal = Double(calorieGoalInput) {
                                    
                                    main.CalorieGoal = newGoal
                                }
                                calorieGoalInput = ""
                            }.alert("Please enter a value greater than 0 calories", isPresented: $showingCalorieAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        }
                    }
                }
                .padding()
                
                // Calories burnt
                HStack {
                    VStack {
                        Text("Current activity goal: \(main.ActivityGoal.formatted()) calories burned a day")
                        HStack {
                            TextField("Enter activity Goal", text: $caloriesBurntInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                            
                            
                            Button("Set Goal") {
                                if (Double(caloriesBurntInput) ?? 0 < 0) {
                                    showingActivityAlert = true
                                }
                                // Convert input to Double and update activity goal
                                else if let newGoal = Double(caloriesBurntInput) {
                                    
                                    main.ActivityGoal = newGoal
                                }
                                caloriesBurntInput = ""
                            }.alert("Please enter a value greater than 0 calories burnt", isPresented: $showingActivityAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        }
                    }
                }
                .padding()
            }
        }

    }

}
