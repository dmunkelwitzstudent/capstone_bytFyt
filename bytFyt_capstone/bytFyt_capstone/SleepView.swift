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
    
    @Environment(\.modelContext) private var modelContext
    @Query var users: [User]
  
  // Observable object to interact with the shared sleep data model.
  @ObservedObject var sleepDataViewModel: SleepDataViewModel
  

  
  // Function to update the hours slept in the SleepDataViewModel.
  func updateSleepModel() {
    
    sleepDataViewModel.updateHoursSlept(newHours: 8)
    
  }
    
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
            
              Text("Goal: \(users[0].SleepGoal / 60) Hours")
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

                  users[0].SleepGoal = (newGoal * 60);
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
            
              Gauge(value: Double(users[0].currentSleep), in: 0...Double(users[0].SleepGoal)) {
              Text("Slept")
                .foregroundColor(AppColorScheme.accentColor)
            }
            
            .gaugeStyle(.accessoryCircularCapacity)
              Text("\(Double(Double(users[0].currentSleep) / 60), specifier: "%.1f") Hours Slept Last Night")
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
                  hoursSlept = newHours;
                  users[0].currentSleep = newHours * 60;
                
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
              Gauge(value: Double(users[0].currentSleepQuality), in: 0...1) {
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
                users[0].currentSleepQuality = sleepQuality;
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
