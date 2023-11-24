//
//  SleepDataViewModel.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/24/23.
//

//  The purpose of this file is to store the data that will be shared between the
//  SleepView and DashboardView. Essentially we want the information available within the
//  SleepView to be viewable on the DashboardView. In this particular instance, hours slept.

import Foundation

//  The "Oberservable Object" protocol allows our views to "observe" changes
//  in data. Essentially allowing data to be passed between views.

class SleepDataViewModel: ObservableObject {
  
  //Variables (placeholders)
  @Published var hoursSlept: Double = 6.0
  @Published var sleepGoal: Double = 8.0
  
  
  func updateHoursSlept(newHours: Double) {
    hoursSlept = newHours
  }
  
  func updateSleepGoal(newGoal: Double) {
    sleepGoal = newGoal
  }
  
}

