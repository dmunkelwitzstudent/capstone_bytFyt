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
    var chosenExercises: [Int];
    var sets: [Int];
    var totalCalories: Int;
    static var listOfExercises: [Exercise] = [];
    
    
    
    
    
    
    init(Name: String, totalCalories: Int) {
        self.Name = Name;
        self.chosenExercises = [];
        self.totalCalories = 0;
        self.sets = [];

    }
    
    
    
    
    func setTotalCalories() {
        
        
        var total: Int = 0;
        var loopCounter: Int = 0;
        
        for _ in self.chosenExercises {
            
            total += Workout.listOfExercises[chosenExercises[loopCounter]].CaloriesBurned * sets[loopCounter];
            loopCounter += 1;
            
        }
        
        
        
        self.totalCalories = total;
    }
    
    static func populateExerciseList() {
        
        // open text file
        // loop through file, line by line
        // reading input, create objects with specified properties. 
        
        
        // add object to array listOfExercises
        
    }
    
    
    
    
    
}
