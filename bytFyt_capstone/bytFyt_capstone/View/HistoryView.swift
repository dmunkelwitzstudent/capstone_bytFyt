//
//  History.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/27/23.
//

import SwiftUI
import Charts

// Define color scheme
struct AppColorScheme {
  static let backgroundColor = Color.gray
  static let accentColor = Color.white
  static let textColor = Color.white
}

// A generic chart view that can display various metrics
struct MetricChartView: View {
  let data: [MetricData]
  let title: String
  
  
  var body: some View {
    VStack {
      Text(title)
        .font(.headline)
        .foregroundColor(AppColorScheme.textColor)
      
      Chart {
        ForEach(data, id: \.day) { metric in
          BarMark(
            x: .value("Day", metric.day),
            y: .value("Value", metric.value)
          )
        }
      }
      .frame(width: 350, height: 500)
    }
    .background(AppColorScheme.backgroundColor)
    .cornerRadius(10)
  }
}

struct MetricData {
  var day: String
  var value: Double
}

struct HistoryView: View {
  
  // Sample data for each chart, covering 7 days
  let sleepData: [MetricData] = [
    MetricData(day: "Mon", value: 6),
    MetricData(day: "Tue", value: 7),
    MetricData(day: "Wed", value: 8),
    MetricData(day: "Thu", value: 5),
    MetricData(day: "Fri", value: 7),
    MetricData(day: "Sat", value: 9),
    MetricData(day: "Sun", value: 6)
  ]
  
  let caloriesBurntData: [MetricData] = [
    MetricData(day: "Mon", value: 300),
    MetricData(day: "Tue", value: 350),
    MetricData(day: "Wed", value: 400),
    MetricData(day: "Thu", value: 300),
    MetricData(day: "Fri", value: 450),
    MetricData(day: "Sat", value: 500),
    MetricData(day: "Sun", value: 350)
  ]
  
  let caloriesConsumedData: [MetricData] = [
    MetricData(day: "Mon", value: 2000),
    MetricData(day: "Tue", value: 1800),
    MetricData(day: "Wed", value: 1900),
    MetricData(day: "Thu", value: 2100),
    MetricData(day: "Fri", value: 2200),
    MetricData(day: "Sat", value: 2300),
    MetricData(day: "Sun", value: 1800)
  ]
  
  let exerciseTimeData: [MetricData] = [
    MetricData(day: "Mon", value: 60),
    MetricData(day: "Tue", value: 45),
    MetricData(day: "Wed", value: 30),
    MetricData(day: "Thu", value: 40),
    MetricData(day: "Fri", value: 50),
    MetricData(day: "Sat", value: 70),
    MetricData(day: "Sun", value: 55)
  ]
  
  var body: some View {
    ZStack {
      AppColorScheme.backgroundColor
        .ignoresSafeArea(edges: .all)
      
      VStack {
        // Dashboard Header
        Text("Health History")
          .font(.largeTitle)
          .foregroundColor(AppColorScheme.textColor)
          .padding()
          .background(AppColorScheme.backgroundColor)
        
        Spacer()
        
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 20) {
            MetricChartView(data: sleepData, title: "Sleep")
            MetricChartView(data: caloriesBurntData, title: "Calories Burned")
            MetricChartView(data: caloriesConsumedData, title: "Calories Consumed")
            MetricChartView(data: exerciseTimeData, title: "Exercise Time")
          }
          .padding()
          Spacer()
        }
        
        // Horizontal Scroll Indication
        Text("Swipe For More ➡️")
          .font(.subheadline)
          .foregroundColor(AppColorScheme.textColor)
          .padding(.bottom)
        
        Spacer()
      }
    }
  }
}

struct HistoryView_Previews: PreviewProvider {
  static var previews: some View {
    HistoryView()
  }
}
