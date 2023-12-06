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
                            TextField("Enter Sleep Goal", text: $sleepGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                            
                            Button("Set Goal") {
                                // Convert input to Double and update sleep goal
                                if let newGoal = Double(sleepGoalInput) {
                                    main.SleepGoal = newGoal
                                }
                                sleepGoalInput = ""
                                
                                
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
                            TextField("Enter Water Goal", text: $waterGoalInput)
                                .textFieldStyle(PlainTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                
                            
                            Button("Set Goal") {
                                
                                // Convert input to Double and update water goal
                                if let newGoal = Double(waterGoalInput) {
                                    main.WaterGoal = newGoal
                                }
                                waterGoalInput = ""
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
                            TextField("Enter Calorie Goal", text: $calorieGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                
                            Button("Set Goal") {
                                
                                // Convert input to Double and update calorie goal
                                if let newGoal = Double(calorieGoalInput) {
                                    
                                    main.CalorieGoal = newGoal
                                }
                                calorieGoalInput = ""
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
                            TextField("Enter Calorie Goal", text: $caloriesBurntInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                            
                            
                            Button("Set Goal") {
                                
                                // Convert input to Double and update activity goal
                                if let newGoal = Double(caloriesBurntInput) {
                                    
                                    main.ActivityGoal = newGoal
                                }
                                caloriesBurntInput = ""
                            }
                        }
                    }
                }
                .padding()
            }
        }

    }

}
