//
//  Entry.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/4/23.
//

import Foundation
import SwiftData





class Entry {
    
    var Date: Date;
    var Weight: Int;
    var Sleep: Int;
    var Calories: Int;
    var WaterIntake: Int;
    
    // Units are as follows, lbs, minutes, kcal, oz.
    
    init (date: Date, weight: Int, sleep: Int, calories: Int, water: Int) {
     
        self.Date = Foundation.Date();
        self.Weight = weight;
        self.Sleep = sleep;
        self.Calories = calories;
        self.WaterIntake = water;

    }
    
    
    
    func getMetricWater() -> Double {
        
        return (Double(self.WaterIntake) * 29.5735);
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

    
}

