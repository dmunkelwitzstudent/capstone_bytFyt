//
//  NutritionView.swift
//  NutritionView
//
//  Created by Steffens, Nick on 11/21/23.
//

import SwiftUI
import SwiftData

struct NutritionView: View {
    
    //Color scheme for NutritionView
    struct AppColorScheme {
        static let backgroundColor = Color.green
        static let accentColor = Color.white
        static let textColor = Color.white
    }
    
    // State variable to store user's weight goal input
    @State private var currentWeightInput: String = "";
    // State variable to store the actual weight goal
    @State private var weightGoal: Double = 0;
    
    // State variable to store the user's hours slept input
    @State private var calorieIntakeInput: String = "";
    // State variable to store the actual hours slept
    @State private var calorieIntake: Double = 0;

    // Used to show alerts
    @State var showAlert: Bool = false;
    @State var alertMsg: String = "";
    
    
    @Environment(\.modelContext) private var modelContext;
    @Query var users: [User];
    
    var body: some View {
        
        let main = users[0];
        
        ZStack {
            AppColorScheme.backgroundColor
                .ignoresSafeArea(edges: .all)
            
            VStack() {
                // Nutrition Tracker Header
                Text("Nutrition Tracker")
                    .font(.largeTitle)
                    .foregroundColor(AppColorScheme.textColor)
                    .background(AppColorScheme.backgroundColor)
                Spacer()
                    .frame(height: 75)
                
                // Nutrition Metrics
                VStack(alignment: .center) {
                    // Nutrition Goal Metric
                    VStack {
                        
                        // Metric vs Imperial
                        
                        if (main.UseMetric) {
                            Text("Weight Goal: \(System.convertImperialWeight(inputWeight: main.WeightGoal), specifier: "%.1f") kg")
                                .font(.title)
                                .foregroundStyle(AppColorScheme.accentColor)
                            
                        } else {
                            Text("Weight Goal: \(main.WeightGoal, specifier: "%.1f") lbs")
                              .font(.title)
                              .foregroundStyle(AppColorScheme.accentColor)
                        }
                        
                        
                        if (main.UseMetric) {
                            Text("Current Weight: \(System.convertImperialWeight(inputWeight: main.currentWeight), specifier: "%.1f") kg")
                                .font(.title)
                                .foregroundStyle(AppColorScheme.accentColor)
                        } else {
                            Text("Current Weight: \(main.currentWeight, specifier: "%.1f") lbs")
                              .font(.title)
                              .foregroundStyle(AppColorScheme.accentColor)
                        }
                        
                        
                        
                    }
                    
                    
                    // TextField and button for setting current weight
                    VStack(alignment: .leading) {
                        HStack {
                            
                            TextField("Enter Current Weight", text: $currentWeightInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .background(AppColorScheme.backgroundColor)
                            
                            Button("Set Weight") {
                                
                                // Validation for metric and imperial for new weight
                                
                                if let newWeight = Double(currentWeightInput) {
                                    
                                    
                                    if (main.UseMetric) {
                                        
                                        if (newWeight < 27 || newWeight > 453) {
                                            alertMsg += "Please enter a weight between 27 and 453kgs ";
                                            showAlert = true;
                                            
                                        } else {
                                            main.currentWeight = System.convertMetricWeight(inputWeight: newWeight);
                                        }
                                        
                                    } else {
                                        
                                        if (newWeight < 60 || newWeight > 1000) {
                                            alertMsg += "Please enter a weight between 60 - 1000lbs";
                                            showAlert = true;
                                        } else {
                                            main.currentWeight = newWeight;
                                        }
                                        
                                    }
                                    
                                } else {
                                    alertMsg += "Please enter a valid weight number";
                                    showAlert = true;
                                }
                                
                                currentWeightInput = ""
                                
                            }
                            .padding()
                            .background(AppColorScheme.accentColor)
                            .foregroundColor(AppColorScheme.backgroundColor)
                            .cornerRadius(8)
                        }
                        .padding()
                        .alert(alertMsg, isPresented: $showAlert) {
                            Button("OK", role: .cancel) {
                                alertMsg = "";
                            }
                            
                        }
                        
                        
                        // Calories Metric
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                VStack {
                                    ZStack {
                                        Circle()
                                            .stroke(
                                                Color.white.opacity(0.5),
                                                lineWidth: 10
                                            ).frame(width: 145, height: 145)
                                        
                                        VStack {
                                            Text("\(main.currentFoodCalories, specifier: "%.0f")")
                                                .font(.title2)
                                            Text("/")
                                                .font(.title2)
                                            Text("\(main.CalorieGoal, specifier: "%.0f") cal")
                                                .font(.title2)
                                        }
                                        Circle()
                                            .trim(from: 0, to: Double(main.currentFoodCalories / main.CalorieGoal))
                                            .stroke(
                                                Color.white,
                                                lineWidth: 10
                                            ).frame(width: 145, height: 145)
                                        // 1
                                            .rotationEffect(.degrees(-90))
                                        
                                    }
                                }
                            
                                VStack {
                                    
                                    
                                    
                                    Button("Add Calories") {
                                        
                                        // Validation
                                        if (Double(calorieIntakeInput) ?? 0 <= 0) {
                                            showAlert = true;
                                            alertMsg = "Please enter a calorie intake value greater than zero";
                                        }
                                        
                                        else if let newCalorieIntake = Double(calorieIntakeInput) {
                                            
                                            main.currentFoodCalories += newCalorieIntake;
                                            
                                            if (main.currentFoodCalories > 20000) {
                                                main.currentFoodCalories = 20000;
                                            }
                                            
                                        }
                                        calorieIntakeInput = "";
                                        
                                    }.alert(alertMsg, isPresented: $showAlert) {
                                        Button("OK", role: .cancel) {
                                            showAlert = false;
                                            alertMsg = "";
                                        }

                                    }
                                    .padding()
                                    .background(AppColorScheme.accentColor)
                                    .foregroundColor(AppColorScheme.backgroundColor)
                                    .cornerRadius(8)
                                    
                                    TextField("Calories", text: $calorieIntakeInput)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad) // Ensures only numbers can be entered
                                        .frame(width: 100, alignment: .center)
                                }
                            }
                            .padding()
                            
                            // Water metric
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    ZStack {
                                        
                                        Circle()
                                            .stroke(
                                                Color.white.opacity(0.5),
                                                lineWidth: 10
                                            ).frame(width: 145, height: 145)
                                        
                                        VStack {
                                            
                                            // Metric vs Imperial
                                            if (main.UseMetric) {
                                                Text("\(System.convertImperialWater(waterAmount: main.currentWater), specifier: "%.0f")")
                                                    .font(.title2)
                                                Text("/")
                                                    .font(.title2)
                                                Text("\(System.convertImperialWater(waterAmount: main.WaterGoal), specifier: "%.0f")ml")
                                                    .font(.title2)
                                            } else {
                                                Text("\(main.currentWater, specifier: "%.0f")")
                                                    .font(.title)
                                                Text("/")
                                                    .font(.title)
                                                Text("\(main.WaterGoal, specifier: "%.0f")oz")
                                                    .font(.title)
                                            }
                                        }
                                        Circle()
                                            .trim(from: 0, to: Double(main.currentWater / main.WaterGoal))
                                            .stroke(
                                                Color.white,
                                                lineWidth: 10
                                            ).frame(width: 145, height: 145)
                                    
                                            .rotationEffect(.degrees(-90))
                                        
                                    }
                                    
                                    HStack {
                                        VStack {
                                            Button("+") {
                                                // Validation
                                                if (main.UseMetric) {
                                                    main.currentWater += 1.6907;
                                                } else {
                                                    main.currentWater  += 8;
                                                }
                                                
                                                if (main.currentWater > 340) {
                                                    main.currentWater = 340;
                                                }
                                                
                                            }
                                            .padding()
                                            .background(AppColorScheme.accentColor)
                                            .foregroundColor(AppColorScheme.backgroundColor)
                                            .cornerRadius(8)
                                            Button("-") {
                                                // Validation
                                                // cannot go below zero
                                                if (main.UseMetric) {
                                                    main.currentWater -= 1.6907;
                                                } else {
                                                    main.currentWater  -= 8;
                                                }
                                                
                                                if (main.currentWater < 0) {
                                                    main.currentWater = 0;
                                                }
                                            }
                                            .padding()
                                            .background(AppColorScheme.accentColor)
                                            .foregroundColor(AppColorScheme.backgroundColor)
                                            .cornerRadius(8)
                                            
                                            
                                        }
                                        Text("Increase or decrease current water intake")
                                            .foregroundColor(.white)
                                    }
                                     
                                }
                                
                                
                            }
                            .padding()
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
}


