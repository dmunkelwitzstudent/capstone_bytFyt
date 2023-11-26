//
//  ActiveView.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/16/23.
//

import SwiftUI
import SwiftData


struct ActiveView: View {
//    @Environment(\.modelContext) private var modelContext;
//    
//    @Query private var users: User;
//    
//    
    
    var exampleList: [String] = ["Chest", "Legs", "Arms"];
    
    
//    var main: User = User.init(firstName: "", lastName: "", birthday: Date(), sex: true, height: 76, startWeight: 76, activity: 1.0, calorieGoal: 6, sleepGoal: 6, weightGoal: 0, metric: true);
//    
//    var list = main.getEntryList(goBack: 30);
//    
//    main.currentWater();
    
    
    // Query Users
    // grab user as main
    // main.valueNeeded
    // OR
    // main.actionNeeded
    
    
    struct AppColorScheme {
        static let backgroundColor = Color.red
      static let accentColor = Color.white
      static let textColor = Color.white
    }
    
    
    
        var body: some View {
            
          ZStack {
            AppColorScheme.backgroundColor
              .ignoresSafeArea(edges: .all)
            
            VStack {
              // Sleep Tracker Header
              Text("Exercise")
                .font(.largeTitle)
                .foregroundColor(AppColorScheme.textColor)
                .padding()
                .background(AppColorScheme.backgroundColor)
                ProgressView(value: 0.7) {
                    
                }
                .accentColor(Color.white)
                Text("140 Calories out of 300 Goal")
                    .foregroundStyle(AppColorScheme.textColor)
                    
              
              Spacer()
              
              // Sleep Metrics
              VStack(alignment: .center, spacing: 200) {

                  Button("Add Workout") {
                      
                  }
                  .accentColor(AppColorScheme.textColor)
 
                  List {
                      
                      HStack {
                          Text("Chest: 60 Calories")
                          Button("Finish Workout") {
                              
                          }

                          
                      }
              
                      HStack {
                          Text("Arms: 40 Calories")
                          Button("Finish Workout") {
                              
                          }
                      }
                      HStack {
                          Text("Legs: 90 Calories")
                          Button("Finish Workout") {
                              
                          }
                          
                      }
        

                  }
                  .background(AppColorScheme.backgroundColor)

              }
              .padding()
              
              Spacer()
            }
          }
        }
      }
        



#Preview {
    ActiveView()
        .modelContainer(for: User.self, inMemory: true)
}
