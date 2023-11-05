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
    
    // Sleep is stored in minutes
    
    var FirstName: String;
    var LastName: String;
    var Birthday: Date
    var Sex: Bool;
    var Height: Double;
    var StartingWeight: Double;
    var CurrentWeight: Double;
    var InitialLogin: Date;
    var ActivityLevel: Double;
    var CalorieGoal: Int;
    var SleepGoal: Int;
    var WeightGoal: Int;
    var DailyEntries: [Entry];
    
    
    init(firstName: String, lastName: String, birthday: Date, sex: Bool, height: Double, startWeight: Double, activity: Double
         , calorieGoal: Int, sleepGoal: Int, weightGoal: Int)  {
        
        
        self.FirstName = firstName;
        self.LastName = lastName;
        self.Birthday = birthday;
        self.Sex = sex;
        self.Height = height;
        self.StartingWeight = startWeight;
        self.CurrentWeight = startWeight;
        self.InitialLogin = Date();
        self.ActivityLevel = activity;
        self.CalorieGoal = calorieGoal;
        self.SleepGoal = sleepGoal;
        self.WeightGoal = weightGoal;
        self.DailyEntries = [];
    }
    
    
    
    func setHeight(newHeight: Double) {
        self.Height = newHeight;
    }
    
    func getAge () -> Int {

        let calendar = Calendar.current

        let components = calendar.dateComponents([.year], from: self.Birthday, to: Date())

        return components.year!
    }
    
    
    func getMetricHeight() -> Double{
        return Double(round(Double(self.Height) * 2.54));
    }
    
    func getMetricWeight() -> Double{
        return Double(self.StartingWeight / 0.453592);
    }
    
    
    
    func getBMI() -> Double {
        return 703 * (Double(self.CurrentWeight / (Double(self.Height) * Double(self.Height))));
    }
    
    func getBMR() -> Double {
        
        var bmr: Double = 5;
        

            
        bmr = (4.536 * self.CurrentWeight);
        bmr += (15.88 * self.Height);
        bmr -= (5 * Double(getAge()));
        
        bmr -= 166;

        
        return bmr;
    }

    
    func getAMR() -> Double {
        return getBMR() * self.ActivityLevel;
    }
    
    func setActivityLevel(newActivity: Double) {
        self.ActivityLevel = newActivity;
    }
    
    func setCalorieGoal(newGoal: Int) {
        self.CalorieGoal = newGoal;
    }
    
    func setSleepGoal(newGoal: Int) {
        self.SleepGoal = newGoal;
    }
    
    
    func weightChange() -> Double {
        return self.StartingWeight - self.CurrentWeight;
    }
    
    

    func getLatestEntry() -> Entry {
        
        
        if (DailyEntries.count != 0) {

            
            return DailyEntries[DailyEntries.count - 1];
            
        }
        
        
    }
    
    
    
    
}
