//
//  GoalView.swift
//  bytFyt_capstone
//
//  Created by Steffens, Nick on 12/4/23.
//

import SwiftUI
import SwiftData

struct GoalView: View {
    
    @Environment(\.modelContext) private var modelContext;
    @Query var users: [User];
    
    
    //Color scheme for GoalView
    struct AppColorScheme {
        static let backgroundColor = Color.blue
        static let accentColor = Color.white
        static let textColor = Color.white
    }
    
    // State variables to store text input
    @State private var sleepGoalInput: String = "";
    @State private var waterGoalInput: String = "";
    @State private var calorieGoalInput: String = "";
    @State private var caloriesBurntInput: String = "";
    @State private var weightGoalInput: String = "";
    
    // Used to show Alerts
    @State var showAlert: Bool = false;
    @State var alertMsg: String = "";
    
    var body: some View {
        let main = users[0];
        
        ZStack {
            AppColorScheme.accentColor
                .ignoresSafeArea(edges: .all)
            
            VStack {
                
                // Dashboard Header'
                Text("\(main.FirstName)'s goals")
                //Applies styles to the views.
                    .font(.largeTitle)
                    .foregroundColor(AppColorScheme.backgroundColor)
                    .padding()
                
                // Sleep goal editing
                HStack {
                    VStack {
                        HStack {
                            Text("Current Sleep goal: \(main.SleepGoal.formatted()) Hours")
                        }
                        HStack {
                            TextField("Enter Sleep goal", text: $sleepGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                            
                            Button("Set Goal") {
                                // Convert input to Double and update sleep goal
                                if (Double(sleepGoalInput) ?? 0 > 24 || Double(sleepGoalInput) ?? 0 < 1) {
                                    showAlert = true;
                                    alertMsg = "Please enter a sleep goal greater than one hour and less than 24 hours";
                                }
                                else if let newGoal = Double(sleepGoalInput) {
                                   main.SleepGoal = newGoal;
                               }
                                sleepGoalInput = "";
                                
                                
                            }
                            .foregroundColor(.purple)
                        }
                    }
                    
                }
                
                
                // Water goal
                HStack {
                    VStack {
                       
                        // Metric vs Imperial
                        if (main.UseMetric) {
                            Text("Current Water Goal: \(System.convertImperialWater(waterAmount: main.WaterGoal), specifier: "%.0f") ml")
                        } else {
                            Text("Current Water Goal: \(main.WaterGoal, specifier: "%.0f") oz")
                        }
                        
                        HStack {
                            TextField("Enter Water goal", text: $waterGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                                
                            
                            Button("Set Goal") {
                                
                                
                                if let newWaterGoal = Double(waterGoalInput) {
                                    
                                    
                                    if (main.UseMetric) {
                                        
                                        if (newWaterGoal < 946 || newWaterGoal > 10000) {
                                            alertMsg += "Please enter a water goal between 946 - 10000ml";
                                            showAlert = true;
                                            
                                        } else {
                                            main.WaterGoal = System.convertMetricWater(waterAmount: newWaterGoal);
                                        }
                                        
                                    } else {
                                        
                                        if (newWaterGoal < 32 || newWaterGoal > 340) {
                                            alertMsg += "Please enter a weight between 32 - 340oz";
                                            showAlert = true;
                                        } else {
                                            main.WaterGoal = newWaterGoal;
                                        }
                                        
                                    }
                                    
                                } else {
                                    alertMsg += "Please enter a valid Water Goal";
                                    showAlert = true;
                                }
                                waterGoalInput = "";
                            }
                            .foregroundColor(.blue)
                        }
                    }
                }
                
                // Calorie goal
                HStack {
                    VStack {
                        Text("Current calorie goal: \(main.CalorieGoal.formatted()) Calories")
                        HStack {
                            TextField("Enter calorie goal", text: $calorieGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                                
                            Button("Set Goal") {
                                if let newCalorieGoal = Double(calorieGoalInput) {

                                    if (newCalorieGoal > 500 && newCalorieGoal < 20000) {
                                        main.CalorieGoal = newCalorieGoal;
                                    } else {
                                        showAlert = true;
                                        alertMsg = "Please enter a calorie intake goal between 500 and 20000";
                                    }
                                    
                                } else  {
                                    showAlert = true;
                                    alertMsg = "Please enter a valid calorie goal";
                                }
                                calorieGoalInput = "";
                            }
                            .foregroundColor(.green)
                        }
                    }
                }
                
                // Calories burnt
                HStack {
                    VStack {
                        Text("Current Activity goal: \(main.ActivityGoal.formatted()) Calories")
                        HStack {
                            TextField("Enter Activity Goal", text: $caloriesBurntInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                            
                            
                            Button("Set Goal") {
                                
                                if let newActivityGoal = Double(caloriesBurntInput) {

                                    if (newActivityGoal > 0 && newActivityGoal < 5000) {
                                        main.ActivityGoal = newActivityGoal;
                                    } else {
                                        showAlert = true;
                                        alertMsg = "Please enter an activity goal between 0 and 5000";
                                    }
                                    
                                } else  {
                                    showAlert = true;
                                    alertMsg = "Please enter a valid Activity goal";
                                }
                                caloriesBurntInput = "";
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                // Weight goal
                HStack {
                    VStack {
                        
                        if (main.UseMetric) {
                            Text("Current Weight Goal: \(System.convertImperialWeight(inputWeight: main.WeightGoal), specifier: "%.1f") kg")
                        } else {
                            Text("Current Weight Goal: \(main.WeightGoal, specifier: "%.1f") lbs")
                        }
                        
                        HStack {
                            TextField("Enter Weight Goal", text: $weightGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .frame(width: 250)
                            Button("Set Goal") {
                                if let newWeightGoal = Double(weightGoalInput) {
                                    
                                    
                                    if (main.UseMetric) {
                                        
                                        if (newWeightGoal < 27 || newWeightGoal > 453) {
                                            alertMsg += "Please enter a weight between 27 and 453kgs ";
                                            showAlert = true;
                                            
                                        } else {
                                            main.WeightGoal = System.convertMetricWeight(inputWeight: newWeightGoal);
                                        }
                                        
                                    } else {
                                        
                                        if (newWeightGoal < 60 || newWeightGoal > 1000) {
                                            alertMsg += "Please enter a weight between 60 - 1000lbs";
                                            showAlert = true;
                                        } else {
                                            main.WeightGoal = newWeightGoal;
                                        }
                                        
                                    }
                                    
                                } else {
                                    alertMsg += "Please enter a valid Weight Goal";
                                    showAlert = true;
                                }
                                weightGoalInput = "";
                            }
                            .foregroundColor(.yellow)
                        }
                    }
                }

                
            }.alert(alertMsg, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    showAlert = false;
                    alertMsg = "";
                }
            }
        }

    }

}
