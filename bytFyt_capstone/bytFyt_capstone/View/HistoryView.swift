//
//  History.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/27/23.
//

import SwiftUI
import Charts

struct HistoryView: View {
    
    // Sample data for the chart
    let sleepData: [SleepData] = [
        SleepData(day: "Mon", hours: 6),
        SleepData(day: "Tue", hours: 7),
        SleepData(day: "Wed", hours: 8),
        SleepData(day: "Thu", hours: 5),
        SleepData(day: "Fri", hours: 7),
        SleepData(day: "Sat", hours: 9),
        SleepData(day: "Sun", hours: 6)
    ]
    
    // Color scheme for DashboardView
    struct AppColorScheme {
        static let backgroundColor = Color.gray
        static let accentColor = Color.white
        static let textColor = Color.white
    }
    
    var body: some View {
        ZStack {
            AppColorScheme.backgroundColor
                .ignoresSafeArea(edges: .all)
            
            VStack {
                // Dashboard Header
                Text("Sleep History")
                    .font(.largeTitle)
                    .foregroundColor(AppColorScheme.textColor)
                    .padding()
                    .background(AppColorScheme.backgroundColor)
                
                Spacer()
                
                // Chart
                Chart {
                    ForEach(sleepData, id: \.day) { data in
                        BarMark(
                            x: .value("Day", data.day),
                            y: .value("Hours", data.hours)
                        )
                    }
                }
                .frame(height: 500)
                
                Spacer()
            }
        }
    }
}

// Simple model for sleep data
struct SleepData {
    var day: String
    var hours: Int
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
