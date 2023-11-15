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
    var repsPerSet: [Int];
    var totalCalories: Int;
    static var listOfExercises: [Exercise] = populateExerciseList();
    
    
    
    
    
    
    init(Name: String, totalCalories: Int) {
        self.Name = Name;
        self.chosenExercises = [];
        self.totalCalories = 0;
        self.sets = [];
        self.repsPerSet = [];

    }
    
    
    
    
    func setTotalCalories() {
        
        
        var total: Int = 0;
        var loopCounter: Int = 0;
        
        for _ in self.chosenExercises {
            
            total += Int(Workout.listOfExercises[chosenExercises[loopCounter]].CaloriesBurned) * sets[loopCounter] *
            repsPerSet[loopCounter];
            loopCounter += 1;
            
        }
        
        
        
        self.totalCalories = total;
    }
    
    static func populateExerciseList() -> [Exercise]{
        
        // open text file
        // loop through file, line by line
        // reading input, create objects with specified properties. 
        
        var populatedExercises: [Exercise] = [];
        
        let workoutNames = ["PushUp", "PullUp", "SitUp"];
        let muscleGroups = ["Chest", "Back", "Core"];
        
        let guides = ["Lay down on your stomach, hold your arms at a 90 degree angle, place your hands down, and simply your body away from the ground. If you cannot do a normal pushup, try putting your knees on the ground.", "Using a stable bar, place your hands at slighly wider than shoulder width apart, pull yourself up.", "Securing your feet on an object, cross your arms and simply sit up."];
        
        let calorieBurns = [0.3, 1, 0.5];
        
        var loopCounter = 0;
        while (loopCounter < workoutNames.count) {
            populatedExercises[loopCounter] = Exercise.init(name: workoutNames[loopCounter], muscleGroup: muscleGroups[loopCounter], guide: guides[loopCounter], calories: calorieBurns[loopCounter]);
            
            loopCounter += 1;
        }
        
        
        // add object to array listOfExercises
        
        return populatedExercises;
        
    }
    
    
    
    
    
}
