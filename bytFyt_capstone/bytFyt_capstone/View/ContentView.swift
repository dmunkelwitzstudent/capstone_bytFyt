//
//  ContentView.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/1/23.
//

import SwiftUI
import SwiftData

//ContentView is the "main" view for the app, defaulted to "
struct ContentView: View {
  // Keep track of which tab is selected
  @State private var selectedTab = "Dashboard"
  
  var body: some View {
    TabView(selection: $selectedTab) {
      //View for dashboard
      DashboardView()
        .tabItem {
          Label("Dashboard", systemImage: "house")
        }
      //Tags as "Dashboard" -- similar to ID
        .tag("Dashboard")
      //View for sleep
      SleepView()
        .tabItem {
          Label("Sleep", systemImage: "moon.zzz")
        }
        .tag("Sleep")
      
      //Add more tabs below when they're done
    }
    //Sets color of tabs
    //TODO: figure out why only selected tab is white...
    .accentColor(.white)
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
