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
    
    // Note: You cannot name a property in swift Description, so it is name Desc.
    
    var Name: String;
    var MuscleGroup: String;
    var Desc: String;
    var TotalCalories: Double;
    
    // This represents a workout that is created by the user, with a defined Name, Muscle Group, Description, and Total Calories
    // Used in ActiveView

    init(name: String) {
        self.Name = name;
        self.MuscleGroup = "Chest & Triceps";
        self.Desc = "Push-Ups and Dips";
        self.TotalCalories = 2;
        
    }
  
}
