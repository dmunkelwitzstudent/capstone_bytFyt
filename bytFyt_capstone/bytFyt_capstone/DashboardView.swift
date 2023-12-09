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
  @Environment(\.modelContext) private var modelContext
  @Query var main: [User];
  
  //Color scheme for DashboardView
  struct AppColorScheme {
    static let backgroundColor = Color.blue
    static let accentColor = Color.white
    static let textColor = Color.black
    static let popColor = Color.mint
  }
  
  var body: some View {
    
    var main = main[0];
    
    @State var sleepGoal: Double = Double(main.SleepGoal);
    @State var currentSleep: Double = Double(main.currentSleep);
    
    @State var currentActiveCalories: Double = Double(main.currentActiveCalories);
    @State var activeGoal: Double = Double(main.ActivityGoal);
    
    @State var currentFoodCalories: Double = Double(main.currentFoodCalories);
    @State var foodGoal: Double = Double(main.CalorieGoal);
    
    @State var currentWater: Double = Double(main.currentWater);
    @State var waterGoal: Double = Double(main.WaterGoal);
    
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
              
              if (main.UseMetric) {
                  Text("Weight:")
                    .font(.title2)
                    .foregroundColor(AppColorScheme.accentColor)
                  Text("\(System.convertImperialWeight(inputWeight: main.currentWeight), specifier: "%.1f") kg")
                      .font(.title)
              } else {
                  Text("Weight:")
                    .font(.title2)
                    .foregroundColor(AppColorScheme.accentColor)
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
                    .font(.title)
                  Text("/")
                    .font(.title)
                  Text("\(main.CalorieGoal, specifier: "%.0f") cal")
                    .font(.title)
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
                  Text("\((main.currentSleep / 60), specifier: "%.1f")")
                    .font(.title)
                  Text("/")
                    .font(.title)
                  Text("\((main.SleepGoal / 60), specifier: "%.0f") hours")
                    .font(.title)
                }
                
                Circle()
                  .trim(from: 0, to: Double((main.currentSleep / 60) / (main.SleepGoal / 60)))
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
          Spacer()        // Dashboard Metrics
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
                  Text("\(main.currentWater, specifier: "%.0f")")
                    .font(.title)
                  Text("/")
                    .font(.title)
                  Text("\(main.WaterGoal, specifier: "%.0f")oz")
                    .font(.title)
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
                    .font(.title)
                  Text("/")
                    .font(.title)
                  Text("\(main.CalorieGoal, specifier: "%.0f") cal")
                    .font(.title)
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
                  Text("\((main.currentSleep / 60), specifier: "%.1f")")
                    .font(.title)
                  Text("/")
                    .font(.title)
                  Text("\((main.SleepGoal / 60), specifier: "%.0f") hours")
                    .font(.title)
                }
                
                Circle()
                  .trim(from: 0, to: Double((main.currentSleep / 60) / (main.SleepGoal / 60)))
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
        }
        
      }
    }
  }
}
