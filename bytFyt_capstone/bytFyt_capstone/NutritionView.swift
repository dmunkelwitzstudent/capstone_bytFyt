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
        
        var main = users[0];
        
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
                        Text("My Weight Goal: \(main.WeightGoal) lbs")
                            .foregroundStyle(AppColorScheme.accentColor)
                        Text("Current Weight: \(main.currentWeight)")
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
                                    
                                    main.WeightGoal =  newGoal;
                                    
                                }
                                
                                
                            }
                            .foregroundColor(AppColorScheme.accentColor)
                        }
                        .padding()
                        
                    }
                    
                    
                    // Calories Metric
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Gauge(value: Double(main.currentFoodCalories), in: 0...Double(main.CalorieGoal)) {
                                Text("Calories")
                                    .foregroundColor(AppColorScheme.accentColor)
                            }
                            
                            .padding()
                            .gaugeStyle(.accessoryCircularCapacity)
                            Text("\(main.currentFoodCalories) out of \(main.CalorieGoal) calories")
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
                                    main.currentFoodCalories += newCalorieIntake;
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
                                        if (main.UseMetric) {
                                            Text("\(System.convertImperialWater(waterAmount: main.currentWater), specifier: "%.0f")")
                                                .font(.title)
                                            Text("/")
                                                .font(.title)
                                            Text("\(System.convertImperialWater(waterAmount: main.WaterGoal), specifier: "%.0f")ml")
                                                .font(.title)
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
                                    
                                    // 1
                                        .rotationEffect(.degrees(-90))
                                    
                                }
                                
                                
                                VStack {
                                    Button("+") {
                                        if (main.UseMetric) {
                                            main.currentWater += 1.6907;
                                        } else {
                                            main.currentWater  += 8;
                                        }
                                        
                                    }
                                    .foregroundColor(.white)
                                    Button("-") {
                                        if (main.UseMetric) {
                                            main.currentWater -= 2;
                                        } else {
                                            main.currentWater  -= 8;
                                        }
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
