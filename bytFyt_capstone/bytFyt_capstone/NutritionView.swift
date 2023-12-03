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
    //@ObservedObject var nutritionDataViewModel: NutritionDataViewModel
    
    // State variable to store user's weight goal input
    @State private var weightGoalInput: String = ""
    // State variable to store the actual weight goal
    @State private var weightGoal: Double = 0
    
    // State variable to store the user's hours slept input
    @State private var calorieIntakeInput: String = ""
    // State variable to store the actual hours slept
    @State private var calorieIntake: Double = 7.5
    
    @State private var glassesOfWaterInput: Double = 0;
    @State private var glassesOfWater: Double = 0;
    
    
    
    @Environment(\.modelContext) private var modelContext
    @Query var users: [User]
    
    var body: some View {
        ZStack {
            AppColorScheme.backgroundColor
                .ignoresSafeArea(edges: .all)
            
            VStack {
                // Nutrition Tracker Header
                Text("Nutrition Tracker")
                    .font(.largeTitle)
                    .foregroundColor(AppColorScheme.textColor)
                    .background(AppColorScheme.backgroundColor)
                
                // Nutrition Metrics
                VStack(alignment: .leading, spacing: 10) {
                    // Nutrition Goal Metric
                    HStack {
                        Gauge(value: 8, in: 0...10) {
                            Text("")
                                .foregroundColor(AppColorScheme.accentColor)
                        }
                        .padding()
                        .gaugeStyle(.accessoryCircularCapacity)
                        Text("My Weight Goal: \(users[0].WeightGoal) lbs")
                            .foregroundStyle(AppColorScheme.accentColor)
                        Text("Current Weight: \(users[0].currentWeight)")
                            .foregroundStyle(AppColorScheme.accentColor)
                        
                    }
                    
                    
                    // TextField and button for setting weight goal
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            
                            TextField("Enter Weight Goal", text: $weightGoalInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            //.keyboardType(.decimalPad) // Ensures only numbers can be entered
                                .padding()
                                .background(AppColorScheme.backgroundColor)
                                .keyboardType(.decimalPad)
                            
                            Button("Set Goal") {
                                
                                if let newGoal = Double(weightGoalInput) {
                                    weightGoal = newGoal
                                    //nutritionDataViewModel.updateWeightGoal(newWeightGoal: newGoal)
                                    
                                    users[0].WeightGoal =  newGoal;
                                    
                                }
                                
                                
                            }
                            .foregroundColor(AppColorScheme.accentColor)
                        }
                        .padding()
                        
                    }
                    
                    
                    // Calories Metric
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Gauge(value: Double(users[0].currentFoodCalories), in: 0...Double(users[0].CalorieGoal)) {
                                Text("Calories")
                                    .foregroundColor(AppColorScheme.accentColor)
                            }
                            
                            .padding()
                            .gaugeStyle(.accessoryCircularCapacity)
                            Text("\(users[0].currentFoodCalories) out of \(users[0].CalorieGoal) calories")
                                .foregroundColor(AppColorScheme.accentColor)
                            
                            
                        }
                        HStack {
                            TextField("Calories", text: $calorieIntakeInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // Ensures only numbers can be entered
                            
                            
                            Button("Add Calories") {
                                if let newCalorieIntake = Double(calorieIntakeInput) {
                                    calorieIntake = newCalorieIntake
                                    // nutritionDataViewModel.updateCalorieIntake(newCalorieIntake: newCalorieIntake)
                                    users[0].currentFoodCalories += newCalorieIntake;
                                }
                                    
                            }
                            .padding()
                            .background(AppColorScheme.backgroundColor)
                            .foregroundColor(AppColorScheme.accentColor)
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
                                        Text("\(users[0].currentWater, specifier: "%.0f")")
                                            .font(.title)
                                        Text("/")
                                            .font(.title)
                                        Text("\(users[0].WaterGoal, specifier: "%.0f")oz")
                                            .font(.title)
                                    }
                                    Circle()
                                        .trim(from: 0, to: Double(users[0].currentWater / users[0].WaterGoal))
                                        .stroke(
                                            Color.white,
                                            lineWidth: 10
                                        ).frame(width: 145, height: 145)
                                    
                                    // 1
                                        .rotationEffect(.degrees(-90))
                                    
                                }
                                
                                
                                VStack {
                                    Button("+") {
                                        users[0].currentWater  += 8;
                                    }
                                    .foregroundColor(.white)
                                    Button("-") {
                                        users[0].currentWater  -= 8;
                                    }
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


#Preview {
    NutritionView()
        .modelContainer(for: [User.self, Workout.self], inMemory: true)
}
