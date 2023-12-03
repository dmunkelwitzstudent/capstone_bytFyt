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

struct ContentView: View {
  
    // Keep track of which tab is selected with a state variable
    @State private var selectedTab = "Dashboard"
  
    // Instance of SleepDataViewModel() to share data between views
    @StateObject var sleepDataViewModel = SleepDataViewModel()
    
    
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User];
    @State var activityLevel: Double = 1.15;

    
    
    @State var fName: String = "";
    @State var lName: String = "";
    
    @State var height: String = "";
    @State var weight: String = "";
    @State var selectedSex: Bool = true;
    @State var birthDate: Date = Date();
    @State var useMetric: Bool = false;
    
    var body: some View {
        

        
        // If there are no USERS! MEANING THE USER HAS NOT ENTERED INFORMATION YET
        if (users.isEmpty) {

            
            
            HStack {
                TextField("First Name", text: $fName)
                    .padding()
                    
                
                TextField("Last Name", text: $lName)
                    .padding()
                    
            }
            
            HStack {
                TextField("Height", text: $height).padding()
                    .keyboardType(.decimalPad)
                TextField("Weight", text: $weight).padding()
                    .keyboardType(.decimalPad)
            }
            
            DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                Text("Birthday: ")
            }
            
            
            Picker("Sex", selection: $selectedSex) {
                Text("Male").tag(true)
                Text("Female").tag(false)
            }
            
            Text("Activity Level")
            
            
            Slider(value: $activityLevel, in: 1...1.75, step: 0.15)
                .frame(width: 300)
            
            Text("Activity Level \(activityLevel, specifier: "%.2f")")
            
            
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
            
            
            
            
            Button ("Use Metric \(String(useMetric))") {
                useMetric = !useMetric;
            }
            
            

      
            
            
            Button("Submit") {
                var main = User.init(firstName: fName, lastName: lName, birthday: birthDate, sex: true, height: Double(height)!, startWeight: Double(weight)!, activity: activityLevel, calorieGoal: 2000, sleepGoal: 460, weightGoal: Double(weight)!, useMetric: useMetric)
                modelContext.insert(main)
                

            }
        } else {
            

            
            // TabView creates a navigation bar
            TabView(selection: $selectedTab) {
                
                //View for dashboard
                DashboardView(sleepDataViewModel: sleepDataViewModel)
                    .tabItem {
                        Label("Dashboard", systemImage: "house")
                    }
                // Tags as "Dashboard" -- similar to ID
                    .tag("Dashboard")
                
                //View for sleep
                SleepView(sleepDataViewModel: sleepDataViewModel)
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

                
                
                // TODO: Add more tabs below when they're finished...
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

/*
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
*/
#Preview {
    ContentView()
        .modelContainer(for: [User.self, Workout.self], inMemory: false)
}
