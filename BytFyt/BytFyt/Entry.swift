//
//  Entry.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/4/23.
//

import Foundation
import SwiftData

// Entry handles the data for daily metric tracking (sleep, calories, activity)
@Model
class Entry {
    
    var Date: Date;
    var Weight: Double;
    var Sleep: Double;
    var SleepQuality: Double;
    var FoodCalories: Double;
    var ActiveCalories: Double;
    var WaterIntake: Double;
    
    // Units are as follows, lbs, hours, kcal, oz.
    // Sleep Quality is a scale of 1-100
    
    init (today: Date, weight: Double, sleep: Double, foodCalories: Double, water: Double, sleepQuality: Double, activeCalories: Double) {
     
        self.Date = today;
        self.Weight = weight;
        self.Sleep = sleep;
        self.FoodCalories = foodCalories;
        self.WaterIntake = water;
        self.SleepQuality = sleepQuality
        self.ActiveCalories = activeCalories;
    }
    

}

