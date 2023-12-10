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
    @State private var weightGoalInput: String = ""
    @State private var showingAlert = false
    @State private var errorMsg = ""
    
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
                                .frame(width: 250)
                            
                            Button("Set Goal") {
                                // Convert input to Double and update sleep goal
                                if (Double(sleepGoalInput) ?? 0 > 24 || Double(sleepGoalInput) ?? 0 < 1) {
                                    showingAlert = true;
                                    errorMsg = "Please enter a sleep goal greater than one hour and less than 24 hours";
                                }
                                else if let newGoal = Double(sleepGoalInput) {
                                                                   main.SleepGoal = newGoal;
                                                               }
                                sleepGoalInput = "";
                                
                                
                            }
                        }
                    }
                    
                }
                
                
                // Water goal
                HStack {
                    VStack {
                        Text("Current water goal: \(main.WaterGoal.formatted()) ounces a day")
                        HStack {
                            TextField("Enter water goal", text: $waterGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                                
                            
                            Button("Set Goal") {
                                if (Double(waterGoalInput) ?? 0 > 1000 || Double(waterGoalInput) ?? 0 < 100) {
                                    showingAlert = true;
                                    errorMsg = "Please enter a water intake goal greater than 0 ounces and less than 1000 ounces";
                                }
                                // Convert input to Double and update water goal
                                else if let newGoal = Double(waterGoalInput) {
                                    main.WaterGoal = newGoal;
                                }
                                waterGoalInput = "";
                            }
                        }
                    }
                }
                
                // Calorie goal
                HStack {
                    VStack {
                        Text("Current calorie goal: \(main.CalorieGoal.formatted()) calories a day")
                        HStack {
                            TextField("Enter calorie goal", text: $calorieGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                                
                            Button("Set Goal") {
                                if (Double(calorieGoalInput) ?? 0 < 0) {
                                    showingAlert = true;
                                    errorMsg = "Please enter a calorie intake goal greater than zero";
                                }
                                // Convert input to Double and update calorie goal
                                else if let newGoal = Double(calorieGoalInput) {
                                    
                                    main.CalorieGoal = newGoal;
                                }
                                calorieGoalInput = "";
                            }
                        }
                    }
                }
                
                // Calories burnt
                HStack {
                    VStack {
                        Text("Current activity goal: \(main.ActivityGoal.formatted()) calories burned a day")
                        HStack {
                            TextField("Enter activity Goal", text: $caloriesBurntInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                            
                            
                            Button("Set Goal") {
                                if (Double(caloriesBurntInput) ?? 0 < 0) {
                                    showingAlert = true;
                                    errorMsg = "Please enter a calories burnt goal greater than zero";
                                }
                                // Convert input to Double and update activity goal
                                else if let newGoal = Double(caloriesBurntInput) {
                                    
                                    main.ActivityGoal = newGoal;
                                }
                                caloriesBurntInput = "";
                            }
                        }
                    }
                }
                // Weight goal
                HStack {
                    VStack {
                        Text("Current weight goal: \(main.WeightGoal.formatted()) pounds")
                        HStack {
                            TextField("Enter activity Goal", text: $weightGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                            Button("Set Goal") {
                                if (Double(weightGoalInput) ?? 0 < 0) {
                                    errorMsg = "Please enter a weight goal greater than zero";
                                    showingAlert = true;
                                    
                                }
                                // Convert input to Double and update activity goal
                                else if let newGoal = Double(weightGoalInput) {
                                    
                                    main.WeightGoal = newGoal;
                                }
                                weightGoalInput = "";
                            }
                        }
                    }
                }

                
            }.alert(errorMsg, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }

    }

}
