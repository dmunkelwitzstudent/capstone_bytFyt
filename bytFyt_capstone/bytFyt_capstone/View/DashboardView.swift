//
//  DashboardView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/11/23.
//

import SwiftUI

struct DashboardView: View {
  
  //Color scheme for DashboardView
  struct AppColorScheme {
    static let backgroundColor = Color.blue
    static let accentColor = Color.white
    static let textColor = Color.white
  }
  
  //NOTE: Stacks are used for formatting content within a view
  var body: some View {
    ZStack {
      AppColorScheme.backgroundColor
        .ignoresSafeArea(edges: .all)
      
      VStack {
        // Dashboard Header
        Text("Dashboard")
          //Applies styles to the views. Try to keep consistent!
          .font(.largeTitle)
          .foregroundColor(AppColorScheme.textColor)
          .padding()
          .background(AppColorScheme.backgroundColor)
        
        Spacer()
        
        // Dashboard Metrics
        VStack(alignment: .leading, spacing: 20) {
          // Daily Calories Remaining
          HStack {
            Gauge(value: 1700, in: 0...2000) {
              Text("Calories")
                .foregroundColor(AppColorScheme.accentColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("Daily Calories Remaining: 830")
              .foregroundColor(AppColorScheme.accentColor)
          }
          
          // Daily Water Remaining
          HStack {
            Gauge(value: 4, in: 0...8) {
              Text("Water")
                .foregroundColor(AppColorScheme.accentColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("Daily Water Remaining: 4 Glasses")
              .foregroundColor(AppColorScheme.accentColor)
          }
          
          // Active Calories Burned Today
          HStack {
            Gauge(value: 140, in: 0...500) {
              Text("Active Calories")
                .foregroundColor(AppColorScheme.accentColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("Active Calories Burned Today: 140")
              .foregroundColor(AppColorScheme.accentColor)
          }
          
          // Hours Slept
          HStack {
            Gauge(value: 7.75, in: 0...8) {
              Text("Sleep")
                .foregroundColor(AppColorScheme.accentColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("Hours Slept: 7.75")
              .foregroundColor(AppColorScheme.accentColor)
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
    DashboardView()
  }
  
}
