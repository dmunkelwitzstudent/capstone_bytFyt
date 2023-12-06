//
//  SleepView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/16/23.
//
//  The purpose of this view is to provide the user of the application with an interactive page of their sleep health.

import SwiftUI
import SwiftData

struct SleepView: View {
  
  //Color scheme for SleepView
  struct AppColorScheme {
    static let backgroundColor = Color.purple
    static let accentColor = Color.white
    static let textColor = Color.white
  }
  
  //Default values for alert related code
  @State var showAlert = false
  
  @State var alertMsg = ""
  
  @Environment(\.modelContext) private var modelContext
  
  @Query var users: [User]
  
  // Observable object to interact with the shared sleep data model.
  //@ObservedObject var sleepDataViewModel: SleepDataViewModel
  
  // Function to update the hours slept in the SleepDataViewModel.
  
  @State  private var sleepGoalInput: String = ""
  // State variable to store the actual sleep goal
  @State  private var sleepGoal: Double = 0;
  
  // State variable to store the user's hours slept input
  @State  private var hoursSleptInput: String = ""
  // State variable to store the actual hours slept
  @State  private var hoursSlept: Double = 0;
  
  // Sleep quality value, range from 0 (Poor) to 1 (Excellent)
  @State  private var sleepQuality: Double = 0.5;
  
  
  var body: some View {
    
    //users[0].currentSleepQuality = Int(sleepQuality);
    
    // State variable to store user's sleep goal input
    
    var main = users[0];
    
    
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
            
            Text("Goal: \(main.SleepGoal / 60) Hours")
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
              if let newGoal = Double(sleepGoalInput), newGoal >= 0 && newGoal <= 24 {
                sleepGoal = newGoal
                
                main.SleepGoal = (newGoal * 60);
              } else {
                alertMsg = "Please enter a valid sleep goal (0-24 hours)."
                showAlert = true
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
            
            Gauge(value: Double(main.currentSleep), in: 0...Double(main.SleepGoal)) {
              Text("Slept")
                .foregroundColor(AppColorScheme.accentColor)
            }
            
            .gaugeStyle(.accessoryCircularCapacity)
            Text("\(Double(Double(main.currentSleep) / 60), specifier: "%.1f") Hours Slept Last Night")
              .foregroundColor(AppColorScheme.accentColor)
          }
          
          // Input for setting hours slept
          HStack {
            TextField("Enter Hours Slept", text: $hoursSleptInput)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .keyboardType(.decimalPad)
              .padding()
            
            Button("Set Hours") {
              if let newHours = Double(hoursSleptInput), newHours >= 0 && newHours <= 24 {
                hoursSlept = newHours
                main.currentSleep = newHours * 60;
              } else {
                alertMsg = "Please enter a valid number of hours slept (0-24 hours)."
                showAlert = true
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
            Gauge(value: Double(main.currentSleepQuality), in: 0...1) {
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
          Button("Update Sleep Quality") {
            main.currentSleepQuality = sleepQuality;
          }.foregroundColor(AppColorScheme.textColor)
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
    .alert(isPresented: $showAlert) {
      Alert(title: Text("Invalid Input"), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
  }
}
