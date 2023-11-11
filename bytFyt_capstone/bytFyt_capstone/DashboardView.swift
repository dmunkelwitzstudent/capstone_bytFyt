//
//  DashboardView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/11/23.
//

import SwiftUI

struct DashboardView: View {
  
  struct AppColorScheme {
    
    static let backgroundColor = Color.blue
    static let accentColor = Color.red
    static let textColor = Color.white
    
  }
  
  var body: some View {
    
    ZStack{
      
      
      
      VStack {
        // Dashboard content
        Text("Dashboard")
          .font(.largeTitle)
          .foregroundColor(AppColorScheme.textColor)
          .padding()
          .background(AppColorScheme.backgroundColor)
        
        Spacer()
        
        // Progress views for each metric
        ProgressView(value: 830, total: 2000) {
          Text("Daily Calories Remaining: 830")
            .accentColor(AppColorScheme.accentColor)
            .padding()
        }
        
        ProgressView(value: 4, total: 8) {
          Text("Daily Water Remaining: 4 Glasses")
            .accentColor(AppColorScheme.accentColor)
            .padding()
        }
        
        ProgressView(value: 140, total: 500) {
          Text("Active Calories Burned Today: 140")
            .accentColor(AppColorScheme.accentColor)
            .padding()
        }
        
        ProgressView(value: 7.75, total: 8) {
          Text("Hours Slept: 7.75\n15 Minutes down from target")
            .accentColor(AppColorScheme.accentColor)
            .padding()
        }
        
        Spacer()
        
        // Tab bar
        TabView {
          // The views for each tab go here
          Text("Home").tabItem {
            Image(systemName: "house")
            Text("Home")
              .accentColor(AppColorScheme.accentColor)
              .padding()
          }
          
          Text("Nutrition").tabItem {
            Image(systemName: "leaf")
            Text("Nutrition")
              .accentColor(AppColorScheme.accentColor)
              .padding()
          }
          
          Text("Workout").tabItem {
            Image(systemName: "flame")
            Text("Workout")
              .accentColor(AppColorScheme.accentColor)
              .padding()
          }
          
          Text("Sleep").tabItem {
            Image(systemName: "moon.zzz")
            Text("Sleep")
              .accentColor(AppColorScheme.accentColor)
              .padding()
          }
        }
      }
    }
  }
  
}

struct DashboardView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardView()
  }
  
}
