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
  
  @StateObject var nutritionDataViewModel = NutritionDataViewModel()
  
  var body: some View {
    
    // TabView creates a navigation bar
    TabView(selection: $selectedTab) {
      
      //View for dashboard
      DashboardView(sleepDataViewModel: sleepDataViewModel, nutritionDataViewModel: nutritionDataViewModel)
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
      
      NutritionView(nutritionDataViewModel: nutritionDataViewModel)
        .tabItem {
          Label("Nutrition", systemImage: "leaf")
        }
        .tag("Nutrition")
      
      HistoryView()
          .tabItem {
              Label("History", systemImage: "chart.bar")
          }
      
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
