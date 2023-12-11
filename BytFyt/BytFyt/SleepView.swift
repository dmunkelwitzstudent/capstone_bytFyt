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
    @State var showAlert = false;
    @State var alertMsg = "";
    
    @Environment(\.modelContext) private var modelContext;
    @Query var users: [User];
    
    
    @State  private var sleepGoalInput: String = "";
    // State variable to store the actual sleep goal
    @State  private var sleepGoal: Double = 0;
    
    // State variable to store the user's hours slept input
    @State  private var hoursSleptInput: String = "";
    // State variable to store the actual hours slept
    @State  private var hoursSlept: Double = 0;
    
    // Sleep quality value, range from 0 - 1, poor - excellent
    // Sleep quality is converted to 0 - 100 for the user object
    @State  private var sleepQuality: Double = 0.5;
    
    
    var body: some View {
        
        let main = users[0];
        
        
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
                    
                    // TextField and Button for setting sleep goal
                    
                    // Hours Slept Metric
                    VStack {
                        
                        ZStack {
                            Circle()
                                .stroke(
                                    Color.white.opacity(0.5),
                                    lineWidth: 10
                                ) .frame(width: 200, height: 200)
                            
                            VStack {
                                Text("\((main.currentSleep), specifier: "%.1f")")
                                    .font(.title)
                                Text("/")
                                    .font(.title)
                                Text("\((main.SleepGoal), specifier: "%.0f") hours")
                                    .font(.title)
                            }
                            
                            Circle()
                                .trim(from: 0, to: Double((main.currentSleep) / (main.SleepGoal)))
                                .stroke(
                                    Color.white,
                                    lineWidth: 10
                                ).frame(width: 200, height: 200)
                            // 1
                                .rotationEffect(.degrees(-90))
                        }
                        VStack {
                            TextField("Hours Slept", text: $hoursSleptInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .padding()
                            
                            Button("Set Hours") {
                                // Validation
                                if let newHours = Double(hoursSleptInput), newHours >= 0 && newHours <= 24 {
                                    hoursSlept = newHours;
                                    main.currentSleep = newHours;
                                } else {
                                    alertMsg = "Please enter a valid number of hours slept (0-24 hours).";
                                    showAlert = true;
                                }
                            }
                            .padding()
                            .background(AppColorScheme.accentColor)
                            .foregroundColor(AppColorScheme.backgroundColor)
                            .cornerRadius(8)
                        }
                    }
                    
                    .padding()
                    
                }
                .padding()
                
                VStack {
                    Text("\(sleepQuality * 100, specifier: "%.0f")% Sleep Quality")
                        .font(.title)
                        .foregroundStyle(AppColorScheme.accentColor)
                    HStack {
                        Text("Poor")
                            .foregroundColor(AppColorScheme.accentColor)
                        Slider(value: $sleepQuality)
                            .accentColor(AppColorScheme.accentColor)
                            .onChange(of: sleepQuality, {
                                // when the sleepQuality variable changes (view level sleepQuality)
                                // main's currentSleepQuality is set to sleepQuality.
                                // It also gets multiplied my 100 for better formatting in HistoryView
                                main.currentSleepQuality = sleepQuality * 100;
                            })
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
