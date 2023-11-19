//
//  SleepView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/16/23.
//


import SwiftUI

struct SleepView: View {
  
  //Color scheme for SleepView
  struct AppColorScheme {
    static let backgroundColor = Color.purple
    static let accentColor = Color.white
    static let textColor = Color.white
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
            Gauge(value: 8, in: 0...10) {
              Text("Goal")
                .foregroundColor(AppColorScheme.accentColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("My Sleep Goal: 8 Hours")
              .foregroundColor(AppColorScheme.accentColor)
          }
          
          // Hours Slept Metric
          HStack {
            Gauge(value: 7.5, in: 0...10) {
              Text("Slept")
                .foregroundColor(AppColorScheme.accentColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("7.5 Hours Slept Last Night")
              .foregroundColor(AppColorScheme.accentColor)
          }
          
          // Quality of Sleep Metric
          HStack {
            Gauge(value: 0.75, in: 0...1) {
              Text("Quality")
                .foregroundColor(AppColorScheme.accentColor)
            }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("75% Sleep Quality")
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
    SleepView()
  }
}

#Preview {
  SleepView()
}
