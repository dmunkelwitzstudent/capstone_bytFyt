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
    var Sleep: Double;
    var SleepQuality: Double;
    var FoodCalories: Double;
    var ActiveCalories: Double;
    var WaterIntake: Double;
    
    // Units are as follows, lbs, minutes, kcal, oz.
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
    
    
    
    func getMetricWater() -> Double {
        
        return (Double(self.WaterIntake) * 29.5735);
        
    }
    
    
    
    func changeSleep(newSleep: Double) {
        self.Sleep += newSleep;
    }
    
    func changeSleepQuality(newQuality: Double) {
        self.SleepQuality = newQuality;
    }
    
    
    func changeWater(newWater: Double) {
        self.WaterIntake += newWater;
    }
    
    
    func changeFoodCalories(newCalories: Double) {
        self.FoodCalories += newCalories;
    }
    
    
    func changeActiveCalories(newCalories: Double) {
        self.ActiveCalories += newCalories;
    }

}

