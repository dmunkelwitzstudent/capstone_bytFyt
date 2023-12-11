//
//  User.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 11/4/23.
//

import Foundation
import SwiftData


@Model
class User {
    
    // Stored data is in imperial measurements, user will be able to toggle metric
    // but the underlying data will remain imperial
    
    // Height and Weight are stored as inches and pounds respectively
    // or CM and KG for metric
    
    // Sleep is stored in hours

    
    //All numbers are stored as doubles for ease of math and displaying.
    var FirstName: String;
    var LastName: String;
    var Birthday: Date;
    
    // True is male, false is female.
    var Sex: Bool;
    var Height: Double;
    
    // Starting information
    var StartingWeight: Double;

    var ActivityLevel: Double;
    var CalorieGoal: Double;
    var ActivityGoal: Double;
    var SleepGoal: Double;
    var WeightGoal: Double;
    var WaterGoal: Double;
    
    // True is Metric, false is Imperial
    var UseMetric: Bool;
    
    // Represents the current days metrics
    var currentFoodCalories: Double;
    var currentSleep: Double;
    var currentWeight: Double;
    var currentActiveCalories: Double;
    var currentSleepQuality: Double;
    var currentWater: Double;
    

    init(firstName: String, lastName: String, birthday: Date, sex: Bool, height: Double, startWeight: Double, activity: Double
         , useMetric: Bool)  {
        
        
        self.FirstName = firstName;
        self.LastName = lastName;
        self.Birthday = birthday;
        self.Sex = sex;
        self.Height = height;
        self.StartingWeight = startWeight;
        self.ActivityLevel = activity;
        
        // Goals
        self.CalorieGoal = 2000;
        self.SleepGoal = 8;
        self.WeightGoal = startWeight;
        self.ActivityGoal = 300;
        self.WaterGoal = 64;
        
        
        self.UseMetric = useMetric;
        self.currentFoodCalories = 0;
        self.currentSleep = 0;
        self.currentWeight = startWeight;
        self.currentActiveCalories = 0;
        self.currentSleepQuality = 0;
        self.currentWater = 0;
        
    }
    

    func getAge () -> Int {

        let calendar = Calendar.current;

        let components = calendar.dateComponents([.year], from: self.Birthday, to: Date());

        return components.year!
    }
    
    func getBMI() -> Double {
        return 703 * ((currentWeight / (Double(self.Height) * Double(self.Height))));
    }
    
    func getBMR() -> Double {
        
        var bmr: Double = 5;
        
        bmr = (4.536 * self.currentWeight);
        bmr += (15.88 * self.Height);
        bmr -= (5 * Double(getAge()));
        
        // if the user is female, change formula for bmr
        if(!self.Sex) {
            bmr -= 166;
        }
        
        return bmr;
    }

    
    func getAMR() -> Double {
        return getBMR() * self.ActivityLevel;
    }
    
    
    func resetCurrentVariables() {
        // this function will reset the current variables, indicating a day has changed
        // currentWeight will not be changed, as it doesn't make sense for that value to get reset every night. 
        self.currentSleep = 0;
        self.currentWater = 0;
        self.currentFoodCalories = 0;
        self.currentSleepQuality = 0;
        self.currentActiveCalories = 0;
    }

}
