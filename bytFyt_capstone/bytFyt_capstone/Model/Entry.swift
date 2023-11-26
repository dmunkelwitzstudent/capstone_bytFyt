//
//  Entry.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/4/23.
//

import Foundation
import SwiftData




@Model
class Entry {
    

    
    var Date: Date;
    var Weight: Double;
    var Sleep: Int;
    var SleepQuality: Int;
    var FoodCalories: Int;
    var ActiveCalories: Int;
    var WaterIntake: Int;
    
    // Units are as follows, lbs, minutes, kcal, oz.
    // Sleep Quality is a scale of 1-5
    
    init (today: Date, weight: Double, sleep: Int, foodCalories: Int, water: Int, sleepQuality: Int, activeCalories: Int) {
     
        self.Date = today;
        self.Weight = weight;
        self.Sleep = sleep;
        self.FoodCalories = foodCalories;
        self.WaterIntake = water;
        self.SleepQuality = sleepQuality
        self.ActiveCalories = activeCalories;
    }
    
    
    
    func getMetricWater() -> Double {
        
        return (Double(self.WaterIntake) * 29.5735);
        
    }
    
    
    
    func changeSleep(newSleep: Int) {
        self.WaterIntake += newSleep;
    }
    
    func changeSleepQuality(newQuality: Int) {
        self.SleepQuality = newQuality;
    }
    
    
    func changeWater(newWater: Int) {
        self.WaterIntake += newWater;
    }
    
    
    func changeFoodCalories(newCalories: Int) {
        self.FoodCalories += newCalories;
    }
    
    
    func changeActiveCalories(newCalories: Int) {
        self.ActiveCalories += newCalories;
    }
    
    
    
    

    
}

