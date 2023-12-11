//
//  DashboardView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/11/23.
//
//  The purpose of this file is the creation of a Dashboard View for users to view quick information about their health metrics.

import SwiftUI
import SwiftData

struct DashboardView: View {
    
    // Observable object that holds the sleep data.
    @Environment(\.modelContext) private var modelContext;
    @Query var main: [User];
    
    //Color scheme for DashboardView
    struct AppColorScheme {
        static let backgroundColor = Color.blue
        static let accentColor = Color.white
        static let textColor = Color.black
        static let popColor = Color.mint
    }
    
    var body: some View {
        
        
        // declaring main as first user in main query
        // There will only ever be one user, so this will always be the user desired.
        let main = main[0];
        
        // State variables to display metrics
        @State var sleepGoal: Double = Double(main.SleepGoal);
        @State var currentSleep: Double = Double(main.currentSleep);
        
        @State var currentActiveCalories: Double = Double(main.currentActiveCalories);
        @State var activeGoal: Double = Double(main.ActivityGoal);
        
        @State var currentFoodCalories: Double = Double(main.currentFoodCalories);
        @State var foodGoal: Double = Double(main.CalorieGoal);
        
        @State var currentWater: Double = Double(main.currentWater);
        @State var waterGoal: Double = Double(main.WaterGoal);
        
        @State var useMetric: Bool = main.UseMetric;
        
        ZStack {
            AppColorScheme.backgroundColor
                .opacity(1.0)
                .ignoresSafeArea(edges: .all)
            
            VStack {
                
                // Dashboard Header
                Text("\(main.FirstName)'s Dashboard:")
                //Applies styles to the views. Try to keep consistent!
                    .font(.largeTitle)
                    .foregroundColor(AppColorScheme.textColor)
                    .padding()
                
                HStack {
                    
                    VStack {
                        
                        Text("Age:")
                            .font(.title2)
                            .foregroundColor(AppColorScheme.accentColor)
                        Text("\(main.getAge())")
                            .font(.title)
                        
                        Spacer()
                        
                        
                        Text("Weight:")
                            .font(.title2)
                            .foregroundColor(AppColorScheme.accentColor)
                        
                        // Metric vs Imperial Text
                        if (main.UseMetric) {
                            Text("\(System.convertImperialWeight(inputWeight: main.currentWeight), specifier: "%.1f") kg")
                                .font(.title)
                        } else {
                            Text("\(main.currentWeight, specifier: "%.1f") lbs")
                                .font(.title)
                        }
                        
                        
                        Spacer()
                        
                        Text("BMI")
                            .font(.title2)
                            .foregroundColor(AppColorScheme.accentColor)
                        Text("\(main.getBMI(), specifier: "%.1f")")
                            .font(.title2)
                        
                        Spacer()
                        
                        HStack{
                            
                            Text("BMR")
                                .font(.title2)
                                .foregroundColor(AppColorScheme.accentColor)
                            Text("\(main.getBMR(), specifier: "%.0f")")
                                .font(.title2)
                            
                            Text("AMR")
                                .font(.title2)
                                .foregroundColor(AppColorScheme.accentColor)
                            Text("\(main.getAMR(), specifier: "%.0f")")
                                .font(.title2)
                        }
                    }
                }
                
                Spacer()
                
                // Circles inside Z stack represent current Metric in a easy to view gauge.
                // Where the full line represents the currentTotal of the metric
                // And the semi transparent one represents the goal.
                
                // Example
                // If the user has a water goal of 72oz, and has drank 48 oz today, the circle would be
                // "2/3 full"
                
                // The second circle is rotated -90degrees, to make the progress grow clockwise.
                
                ZStack{
                    RoundedRectangle(cornerRadius: 0.0)
                        .fill(AppColorScheme.accentColor)
                        .shadow(radius: 10, x: 0, y: 4)
                    
                    Spacer()
                    
                    // Dashboard Metrics
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Spacer()
                        
                        HStack {
                            
                            Spacer()
                            
                            // Water
                            ZStack {
                                Circle()
                                    .stroke(
                                        Color.blue.opacity(0.5),
                                        lineWidth: 10
                                    ).frame(width: 145, height: 145)
                                
                                VStack {
                                    
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
                                        Color.blue,
                                        lineWidth: 10
                                    ).frame(width: 145, height: 145)
                                    .rotationEffect(.degrees(-90))
                            }
                            
                            Spacer()
                            
                            // Food
                            ZStack {
                                Circle()
                                    .stroke(
                                        Color.green.opacity(0.5),
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
                                        Color.green,
                                        lineWidth: 10
                                    ).frame(width: 145, height: 145)
                                // 1
                                    .rotationEffect(.degrees(-90))
                            }
                            Spacer()
                        }
                        Spacer()
                        
                        HStack {
                            
                            Spacer()
                            
                            // Sleep
                            ZStack {
                                Circle()
                                    .stroke(
                                        Color.purple.opacity(0.5),
                                        lineWidth: 10
                                    ) .frame(width: 145, height: 145)
                                
                                VStack {
                                    Text("\((main.currentSleep), specifier: "%.1f")")
                                        .font(.title2)
                                    Text("/")
                                        .font(.title2)
                                    Text("\((main.SleepGoal), specifier: "%.1f") hours")
                                        .font(.title2)
                                }
                                
                                Circle()
                                    .trim(from: 0, to: Double((main.currentSleep) / (main.SleepGoal)))
                                    .stroke(
                                        Color.purple,
                                        lineWidth: 10
                                    ).frame(width: 145, height: 145)
                                // 1
                                    .rotationEffect(.degrees(-90))
                            }
                            
                            Spacer()
                            // Active
                            ZStack {
                                Circle()
                                    .stroke(
                                        Color.red.opacity(0.5),
                                        lineWidth: 10
                                    ).frame(width: 145, height: 145)
                                VStack {
                                    Text("\(main.currentActiveCalories, specifier: "%.0f")")
                                        .font(.title)
                                    Text("/")
                                        .font(.title)
                                    Text("\(main.ActivityGoal, specifier: "%.0f") cal")
                                        .font(.title)
                                }
                                Circle()
                                    .trim(from: 0, to: Double(main.currentActiveCalories / main.ActivityGoal))
                                    .stroke(
                                        Color.red,
                                        lineWidth: 10
                                    ).frame(width: 145, height: 145)
                                    .rotationEffect(.degrees(-90))
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        
                        
                    }
                    Spacer()
                }
                
            }
        }
    }
}
