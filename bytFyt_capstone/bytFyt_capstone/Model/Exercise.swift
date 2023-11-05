//
//  Exercise.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/4/23.
//

import Foundation
import SwiftData



@Model
class Exercise {
    
    // Stored data is in imperial measurements, user will be able to toggle metric
    // but the underlying data will remain imperial
    
    var Name: String;
    var MuscleGroup: String;
    var Guide: String;
    var CaloriesBurned: Int;
    
    
    init (name: String, muscleGroup: String, guide: String, calories: Int) {
        self.Name = name;
        self.MuscleGroup = muscleGroup;
        self.Guide = guide;
        self.CaloriesBurned = calories;
    }
    

}

