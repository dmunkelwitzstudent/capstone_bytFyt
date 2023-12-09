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
    
    // Height and Weight(s) are stored as inches and pounds respectively
    // or cm and KG
    
    // Sleep is stored in hours
    
    
    
    // the following properties will not be changed,
    // or in the case of height, will only be changed rarely for certain people
    var FirstName: String;
    var LastName: String;
    var Birthday: Date;
    var Sex: Bool;
    var Height: Double;
    
    // Starting information
    var StartingWeight: Double;
    var InitialLogin: Date;

    var ActivityLevel: Double;
    var CalorieGoal: Double;
    var ActivityGoal: Double;
    var SleepGoal: Double;
    var WeightGoal: Double;
    var WaterGoal: Double;
    

    

    var UseMetric: Bool;
    
    var currentFoodCalories: Double;
    var currentSleep: Double;
    var currentWeight: Double;
    var currentActiveCalories: Double;
    var currentSleepQuality: Double;
    var currentWater: Double;
    
    
    
    
    init(firstName: String, lastName: String, birthday: Date, sex: Bool, height: Double, startWeight: Double, activity: Double
         , calorieGoal: Double, sleepGoal: Double, weightGoal: Double, useMetric: Bool)  {
        
        
        self.FirstName = firstName;
        self.LastName = lastName;
        self.Birthday = birthday;
        self.Sex = sex;
        self.Height = height;
        self.StartingWeight = startWeight;
        self.InitialLogin = Date();
        self.ActivityLevel = activity;
        
        // Goals
        self.CalorieGoal = calorieGoal;
        self.SleepGoal = sleepGoal;
        self.WeightGoal = weightGoal;
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
    

    
    func setHeight(newHeight: Double) {
        self.Height = newHeight;
    }
    
    func getAge () -> Int {

        let calendar = Calendar.current

        let components = calendar.dateComponents([.year], from: self.Birthday, to: Date())

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
    
    func setActivityLevel(newActivity: Double) {
        self.ActivityLevel = newActivity;
    }
    
    func setCalorieGoal(newGoal: Double) {
        self.CalorieGoal = newGoal;
    }
    
    func setSleepGoal(newGoal: Double) {
        self.SleepGoal = newGoal;
    }
    
    
    func setWeightGoal(newWeight: Double) {
        self.WeightGoal = newWeight;
    }
    
    func setCurrentWeight(currentWeight: Double) {
        self.currentWeight = currentWeight;
    }
    
    func addCurrentSleep(currentSleep: Double) {
        self.currentSleep = currentSleep;
    }
    
    func setSleepQuality(currentSleepQuality: Double) {
        self.currentSleepQuality = currentSleepQuality;
    }
    
    func addFoodCalories(addCalories: Double) {
        self.currentFoodCalories += addCalories;
    }
    
    func addWaterIntake(addWater: Double) {
        self.currentWater = addWater;
    }
    
    
    
    func resetCurrentVariables() {
        self.currentSleep = 0;
        self.currentWater = 0;
        self.currentFoodCalories = 0;
        self.currentSleepQuality = 0;
        self.currentFoodCalories = 0;
    }
    


    
}
