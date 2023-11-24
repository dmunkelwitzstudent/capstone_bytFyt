//
//  SleepView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/16/23.
//
//  The purpose of this view is to provide the user of the application with an interactive page of their sleep health.


import SwiftUI

struct SleepView: View {
  
  //Color scheme for SleepView
  struct AppColorScheme {
    static let backgroundColor = Color.purple
    static let accentColor = Color.white
    static let textColor = Color.white
  }
  
  // Observable object to interact with the shared sleep data model.
  @ObservedObject var sleepDataViewModel: SleepDataViewModel
  
  // State variable to store user's sleep goal input
  @State private var sleepGoalInput: String = ""
  // State variable to store the actual sleep goal
  @State private var sleepGoal: Double = 8
  
  // State variable to store the user's hours slept input
  @State private var hoursSleptInput: String = ""
  // State variable to store the actual hours slept
  @State private var hoursSlept: Double = 7.5
  
  // Sleep quality value, range from 0 (Poor) to 1 (Excellent)
  @State private var sleepQuality: Double = 0.5
  
  // Function to update the hours slept in the SleepDataViewModel.
  func updateSleepModel() {
    
    sleepDataViewModel.updateHoursSlept(newHours: 8)
    
  }
  
  
  var body: some View {
    ZStack {
      
      AppColorScheme.backgroundColor
        .ignoresSafeArea(edges: .all)
      
      VStack {
        
        // Sleep Tracker Header
        Text("Sleep Tracker")
          .font(.largeTitle)
          .foregroundColor(AppColorScheme.textColor)
          .padding()
          .background(AppColorScheme.backgroundColor)
        
        Spacer()
        
        // Sleep Metrics
        VStack(alignment: .leading, spacing: 20) {
          
          // Sleep Goal Metric
          HStack {
            
            Spacer()
            
            Text("Goal: \(Int(sleepGoal)) Hours")
              .font(.system(size: 50))
              .fontWeight(.bold)
              .foregroundColor(AppColorScheme.accentColor)
            
            Spacer()
            
          }
          
          // TextField and Button for setting sleep goal
          HStack {
            
            TextField("Enter Sleep Goal", text: $sleepGoalInput)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad) // Ensures only numbers can be entered
              .padding()
            
            Button("Set Goal") {
              
              // Convert input to Double and update sleep goal
              if let newGoal = Double(sleepGoalInput) {
                sleepGoal = newGoal
                sleepDataViewModel.updateSleepGoal(newGoal: newGoal)
                
              }
              
            }
            .padding()
            .background(AppColorScheme.accentColor)
            .foregroundColor(AppColorScheme.backgroundColor)
            .cornerRadius(8)
          }
          .padding()
          
          Spacer()
          
          // Hours Slept Metric
          HStack {
            
            Gauge(value: hoursSlept, in: 0...sleepGoal) {
              Text("Slept")
                .foregroundColor(AppColorScheme.accentColor)
            }
            
            .gaugeStyle(.accessoryCircularCapacity)
            Text("\(hoursSlept, specifier: "%.1f") Hours Slept Last Night")
              .foregroundColor(AppColorScheme.accentColor)
          }
          
          // Input for setting hours slept
          HStack {
            TextField("Enter Hours Slept", text: $hoursSleptInput)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad)
              .padding()
            
            Button("Set Hours") {
              if let newHours = Double(hoursSleptInput) {
                hoursSlept = newHours
                sleepDataViewModel.updateHoursSlept(newHours: newHours)
              }
            }
            .padding()
            .background(AppColorScheme.accentColor)
            .foregroundColor(AppColorScheme.backgroundColor)
            .cornerRadius(8)
          }
          .padding()
          
          Spacer()
          
          // Quality of Sleep Metric
          HStack {
            Gauge(value: sleepQuality, in: 0...1) {
              Text("Quality")
                .foregroundColor(AppColorScheme.accentColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("\(Int(sleepQuality * 100))% Sleep Quality")
              .foregroundColor(AppColorScheme.accentColor)
          }
        }
        .padding()
        
        VStack {
          Text("Sleep Quality")
            .foregroundColor(AppColorScheme.textColor)
          
          HStack {
            Text("Poor")
              .foregroundColor(AppColorScheme.accentColor)
            Slider(value: $sleepQuality)
              .accentColor(AppColorScheme.accentColor)
            Text("Excellent")
              .foregroundColor(AppColorScheme.accentColor)
          }
        }
        .padding()
        
        Spacer()
      }
    }
  }
}

struct SleepView_Previews: PreviewProvider {
  static var previews: some View {
    
    // Create a mock instance of SleepDataViewModel
    let testSleepDataViewModel = SleepDataViewModel()
    
    // Use the mock instance for preview
    SleepView(sleepDataViewModel: testSleepDataViewModel)
    
  }
}
