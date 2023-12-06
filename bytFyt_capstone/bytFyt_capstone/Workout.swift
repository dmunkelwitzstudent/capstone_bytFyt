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
    
    
    var Name: String;
    var MuscleGroup: String;
    var Desc: String;
    var TotalCalories: Double;
    
    
    init(name: String) {
        self.Name = name;

        self.MuscleGroup = "Chest & Triceps";
        self.Desc = "Push-Ups and Dips";
        self.TotalCalories = 2;
        
    }
    

  
       
        
}
