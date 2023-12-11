//
//  ContentView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/1/23.
//
//  The purpose of ContentView.swift is to serve as a sort of "parent"
//  to other views the app utilizes.


import SwiftUI
import SwiftData
import UIKit
import Foundation


struct ContentView: View {
    
    // Keep track of which tab is selected with a state variable
    @State private var selectedTab = "Dashboard";
    
    // The following statements will set up the modelContext and queries for us to manipulate
    @Environment(\.modelContext) var modelContext;
    @Query private var users: [User];
    @Query private var entries: [Entry];
    

    // The following state variables represent information needed for the first time login.
    
    @State var fName: String = "";
    @State var lName: String = "";
    
    @State var height: String = "";
    @State var weight: String = "";
    
    // These represent a way to cleanly push these variables into the user
    @State var finalWeight: Double = 0;
    @State var finalHeight: Double = 0;
    
    @State var activityLevel: Double = 1.15;
    
    @State var selectedSex: Bool = true;
    @State var birthDate: Date = Date();
    @State var useMetric: Bool = false;
    
    // Used to display alerts
    @State var showAlert = false
    @State var alertMsg = "";
    
    //For display if the user wishes to use metric.
    @State var heightUnit = "in";
    @State var weightUnit = "lb";
    @State var unitSystem = "Imperial";
    
    
    
    var loopCounter = 0;
    
    // This is used to check if the day has changed in a timer below.
    @State var currentDay: Date = Date();
    
    var body: some View {
        
        
        // If there are no USERS! Meaning we need to display the initial login menu
        if (users.isEmpty) {
            
            
            
            HStack {
                TextField("First Name", text: $fName)
                    .padding()
                
                
                TextField("Last Name", text: $lName)
                    .padding()
                
            }
            .padding()
            
            HStack {
                TextField("Height: \(heightUnit)", text: $height).padding()
                    .keyboardType(.decimalPad)
                TextField("Weight: \(weightUnit)", text: $weight).padding()
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                Text("Birthday: ")
            }
            .padding()
            
            
            Picker("Sex", selection: $selectedSex) {
                Text("Male").tag(true)
                Text("Female").tag(false)
            }
            
            
            Text("Activity Level")
                .font(.title2)
            Slider(value: $activityLevel, in: 1...1.75, step: 0.15)
                .frame(width: 300)
            
            VStack {
                
                
                Text("\(activityLevel, specifier: "%.2f")")
                    .font(.title2)
                
                if (activityLevel == 1) {
                    Text("Little to no exercise")
                }
                if (activityLevel == 1.15) {
                    Text("Light exercise 1-2 times per week")
                }
                if (activityLevel == 1.30) {
                    Text("Moderate exercise 1-2 times per week")
                }
                if (activityLevel == 1.45) {
                    Text("Moderate exercise 3-4 times per week")
                }
                if (activityLevel == 1.60) {
                    Text("Heavy exercise 3-4 times per week")
                }
                if (activityLevel == 1.75) {
                    Text("Heavy exercise almost everyday")
                }
            }
            .padding()
            
            Button ("Currently using \(unitSystem)") {
                
                useMetric = !useMetric;
                
                if (useMetric) {
                    unitSystem = "Metric";
                    heightUnit = "cm";
                    weightUnit = "kg";
                } else {
                    unitSystem = "Imperial";
                    heightUnit = "in";
                    weightUnit = "lb";
                }
            }
            .padding()
            
            
            Button("Submit") {
                
                // For both height and weight, the code needs to check if metric has been selected.
                // After determining Metric or Imperial, certain validations have to be made
                
                if let newHeight = Double(height) {
                    
                    
                    if (useMetric) {
                        
                        if (newHeight < 90 || newHeight > 260) {
                            alertMsg += "\nPlease enter a height between 90 and 260cm";
                            showAlert = true;
                            
                        } else {
                            finalHeight = System.convertMetricHeight(inputHeight: newHeight);
                        }
                        
                    } else {
                        
                        if (newHeight < 36 || newHeight > 108) {
                            alertMsg += "\nPlease enter a height between 36 and 108in";
                            showAlert = true;
                        } else {
                            finalHeight = newHeight;
                        }
                        
                    }
                    
                } else {
                    alertMsg += "\nPlease enter a valid height number";
                    showAlert = true;
                }
                
                if let newWeight = Double(weight) {
                    
                    
                    if (useMetric) {
                        
                        if (newWeight < 27 || newWeight > 453) {
                            alertMsg += "\nPlease enter a weight between 27 and 453kgs ";
                            showAlert = true;
                            
                        } else {
                            finalWeight = System.convertMetricWeight(inputWeight: newWeight);
                        }
                        
                    } else {
                        
                        if (newWeight < 60 || newWeight > 1000) {
                            alertMsg += "\nPlease enter a weight between 60 - 1000lbs";
                            showAlert = true;
                        } else {
                            finalWeight =  newWeight;
                        }
                        
                    }
                    
                } else {
                    alertMsg += "\nPlease enter a valid weight number";
                    showAlert = true;
                }
                
                if (fName == "") {
                    showAlert = true;
                    alertMsg = "\nPlease enter a Name"
                }
                
                
                
                // if the code above executed with no errors, the User object will be created and pushed to the
                // modelContext
                if (!showAlert) {
                    
                    var main = User.init(firstName: fName, lastName: lName, birthday: birthDate, sex: true, height: finalHeight, startWeight: finalWeight, activity: activityLevel, useMetric: useMetric)
                    
                    modelContext.insert(main);
                }
                
                // if there are errors, the alert will be triggered, and no object will be created.
                
            }
            .alert("\(alertMsg)", isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    alertMsg = "";
                    showAlert = !showAlert;
                }
            }
        } else {
            
            let main = users[0];
            
            var timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { (timer) in
                
                
                // every 5 minutes, this code will be exectuted
                
                // Essentially, this if block determines if the currentDay variable is equal to the actual current timestamp
                // AKA Date(), because Date() returns the current timestamp
                
                // currentDay is initialized at the top of the struct
                
                if (System.getFormat(inputDate: Date()) != System.getFormat(inputDate: currentDay)) {
                    
                    // if the days are different, the user had the app open at midnight, so an Entry object
                    // will be pushed, and the currentDay will be set to the current timestamp: Date()
                    var newEntry = Entry(today: Date() - 600, weight: main.currentWeight, sleep: main.currentSleep, foodCalories: main.currentFoodCalories, water: main.currentWater, sleepQuality: main.currentSleepQuality, activeCalories: main.currentActiveCalories);
                    
                    currentDay = Date();
                    modelContext.insert(newEntry);
                    main.resetCurrentVariables();
                    // the users current variables (which represents what they did that day), are reset.
                }
                
            }
            
            
            // TabView creates a navigation bar
            TabView(selection: $selectedTab) {
                
                //View for dashboard
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "house")
                    }
                // Tags as "Dashboard" -- similar to ID
                    .tag("Dashboard")
                
                //View for sleep
                SleepView()
                    .tabItem {
                        Label("Sleep", systemImage: "moon.zzz")
                    }
                    .tag("Sleep")
                
                NutritionView()
                    .tabItem {
                        Label("Nutrition", systemImage: "leaf.arrow.circlepath")
                    }
                    .tag("Nutrition")
                
                
                ActiveView()
                    .tabItem {
                        Label("Active", systemImage: "flame")
                    }
                    .tag("Active")
                
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "chart.bar")
                    }
                    .tag("History")
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag("Settings")
                
                GoalView()
                    .tabItem {
                        Label("Goal", systemImage: "trophy")
                    }
                    .tag("Goal")
                
                
                
            }
            //Sets color of tabs
            .accentColor(.blue)
            
            //Configure the TabView when it appears on screen
            .onAppear {
                // Create a new UITabBarAppearance change the tab bar's appearance
                let appearance = UITabBarAppearance()
                
                // Set the background color of the tab bar
                appearance.backgroundColor = UIColor.white
                
                // Set the color for unselected items
                appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                
                // Use this appearance for both standard and scroll edge appearance
                UITabBar.appearance().standardAppearance = appearance
                
                // This property comes into play when the tab bar is used in conjunction with a large title navigation bar(needed for our app apparently)
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
    
    
}

