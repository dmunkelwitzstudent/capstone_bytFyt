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
  @ObservedObject var sleepDataViewModel: SleepDataViewModel
  @Environment(\.modelContext) private var modelContext
  @Query var users: [User];
    
    

  
  //Color scheme for DashboardView
  struct AppColorScheme {
    static let backgroundColor = Color.blue
    static let accentColor = Color.white
    static let textColor = Color.white
  }

  var body: some View {

      @State var sleepGoal: Double = Double(users[0].SleepGoal);
      @State var currentSleep: Double = Double(users[0].currentSleep);
      
      @State var currentActiveCalories: Double = Double(users[0].currentActiveCalories);
      @State var activeGoal: Double = Double(users[0].ActivityGoal);
      
      @State var currentFoodCalories: Double = Double(users[0].currentFoodCalories);
      @State var foodGoal: Double = Double(users[0].CalorieGoal);
    
      
      @State var currentWater: Double = Double(users[0].currentWater);
      @State var waterGoal: Double = Double(users[0].WaterGoal);
      
    ZStack {
      AppColorScheme.accentColor
        .ignoresSafeArea(edges: .all)
      
      VStack {
        
        // Dashboard Header
          Text("\(users[0].FirstName): \(users[0].currentWeight, specifier: "%.1f") lbs")
        //Applies styles to the views. Try to keep consistent!
          .font(.largeTitle)
          .foregroundColor(AppColorScheme.backgroundColor)
          .padding()
          HStack {
              
              
              
              
              VStack {
                  Text("BMI")
                      .font(.title2)
                      .foregroundColor(.gray)
                  Text("\(users[0].getBMI(), specifier: "%.1f")")
                      .font(.title2)
                      
                  Text("BMR")
                      .font(.title2)
                      .foregroundColor(.gray)
                  Text("\(users[0].getBMR(), specifier: "%.0f")")
                      .font(.title2)
                      
                  Text("AMR")
                      .font(.title2)
                      .foregroundColor(.gray)
                  Text("\(users[0].getAMR(), specifier: "%.0f")")
                      .font(.title2)
                      
                  
              }
              
          }
          

        
        Spacer()
        
        // Dashboard Metrics
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                
                // Water
                
                ZStack {
                    
                    
                    Circle()
                        .stroke(
                            Color.blue.opacity(0.5),
                            lineWidth: 10
                        ).frame(width: 145, height: 145)
                    
                    VStack {
                        Text("\(currentWater, specifier: "%.0f")")
                            .font(.title)
                        Text("/")
                            .font(.title)
                        Text("\(waterGoal, specifier: "%.0f")oz")
                            .font(.title)
                    }
                    Circle()
                        .trim(from: 0, to: Double(currentWater / waterGoal))
                        .stroke(
                            Color.blue,
                            lineWidth: 10
                        ).frame(width: 145, height: 145)
                    
                    // 1
                        .rotationEffect(.degrees(-90))
                    
                }
                
                
                // Food
                ZStack {
                    Circle()
                        .stroke(
                            Color.green.opacity(0.5),
                            lineWidth: 10
                        ).frame(width: 145, height: 145)
                    
                    VStack {
                        Text("\(currentFoodCalories, specifier: "%.0f")")
                            .font(.title)
                        Text("/")
                            .font(.title)
                        Text("\(foodGoal, specifier: "%.0f") cal")
                            .font(.title)
                    }
                    Circle()
                        .trim(from: 0, to: Double(currentFoodCalories / foodGoal))
                        .stroke(
                            Color.green,
                            lineWidth: 10
                        ).frame(width: 145, height: 145)
                    // 1
                        .rotationEffect(.degrees(-90))
                    
                }
                
            }
          
            HStack {
                // Sleep
                ZStack {
                    Circle()
                        .stroke(
                            Color.purple.opacity(0.5),
                            lineWidth: 10
                        ) .frame(width: 145, height: 145)
                    
                    
                    VStack {
                        Text("\((currentSleep / 60), specifier: "%.1f")")
                            .font(.title)
                        Text("/")
                            .font(.title)
                        Text("\((sleepGoal / 60), specifier: "%.0f") hours")
                            .font(.title)
                    }
                    Circle()
                        .trim(from: 0, to: Double((currentSleep / 60) / (sleepGoal / 60)))
                        .stroke(
                            Color.purple,
                            lineWidth: 10
                        ).frame(width: 145, height: 145)
                    // 1
                        .rotationEffect(.degrees(-90))
                    
                }
                
                
                
                // Active
                ZStack {
                    Circle()
                        .stroke(
                            Color.red.opacity(0.5),
                            lineWidth: 10
                        ).frame(width: 145, height: 145)
                    
                    VStack {
                        Text("\(currentActiveCalories, specifier: "%.0f")")
                            .font(.title)
                        Text("/")
                            .font(.title)
                        Text("\(activeGoal, specifier: "%.0f") cal")
                            .font(.title)
                    }
                    Circle()
                        .trim(from: 0, to: Double(currentActiveCalories / activeGoal))
                        .stroke(
                            Color.red,
                            lineWidth: 10
                        ).frame(width: 145, height: 145)
                    // 1
                        .rotationEffect(.degrees(-90))
                    
                }
            }
        }
        .padding()
        
        Spacer()
      }
    }
  }
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    
    // Create a mock instance of SleepDataViewModel
    let testSleepDataViewModel = SleepDataViewModel()
    
    // Use the mock instance for preview
    DashboardView(sleepDataViewModel: testSleepDataViewModel)
    
  }
}
