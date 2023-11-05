//
//  Workout.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/4/23.
//

import Foundation
import SwiftUI
import SwiftData





@Model
class Workout {
    
    
    @Attribute(.unique) var Name: String;
    var exercises: [Exercise];
    var sets: [Int];
    var totalCalories: Int;
    
    
    
    
    
    
    init(Name: String, totalCalories: Int) {
        self.Name = Name;
        self.exercises = [];
        self.totalCalories = 0;
        self.sets = [];
    }
    
    
    
    
    func setTotalCalories() {
        
        
        var total: Int = 0;
        var loopCounter: Int = 0;
        
        for exercise in self.exercises {
            
            total += exercise.CaloriesBurned * sets[loopCounter];
            loopCounter += 1;
            
        }
        
        
        
        self.totalCalories = total;
    }
    
    
    
    
    
}
