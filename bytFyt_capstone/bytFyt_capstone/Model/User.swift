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
    var CalorieGoal: Int;
    var ActivityGoal: Int;
    var SleepGoal: Int;
    var WeightGoal: Double;
    
    var DailyEntries: [Entry];

    
    var UseMetric: Bool;
    
    var currentFoodCalories: Int;
    var currentSleep: Int;
    var currentWeight: Double;
    var currentActiveCalories: Int;
    var currentSleepQuality: Int;
    var currentWater: Int;
    
    
    
    
    init(firstName: String, lastName: String, birthday: Date, sex: Bool, height: Double, startWeight: Double, activity: Double
         , calorieGoal: Int, sleepGoal: Int, weightGoal: Double, metric: Bool)  {
        
        
        self.FirstName = firstName;
        self.LastName = lastName;
        self.Birthday = birthday;
        self.Sex = sex;
        self.Height = height;
        self.StartingWeight = startWeight;
        
        self.InitialLogin = Date();
        self.ActivityLevel = activity;
        self.CalorieGoal = calorieGoal;
        self.SleepGoal = sleepGoal;
        self.WeightGoal = weightGoal;
        self.ActivityGoal = 0;
        self.DailyEntries = [];
        
        self.UseMetric = metric;
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
    
    
    func convertMetricHeight(inputHeight: Double) -> Double{
        return Double(round(Double(inputHeight) * 2.54));
    }
    
    func convertMetricWeight(inputWeight: Double) -> Double{
        return (inputWeight / 0.453592);
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
    
    func setCalorieGoal(newGoal: Int) {
        self.CalorieGoal = newGoal;
    }
    
    func setSleepGoal(newGoal: Int) {
        self.SleepGoal = newGoal;
    }
    
    
    func setWeightGoal(newWeight: Double) {
        self.WeightGoal = newWeight;
    }
    
    func setCurrentWeight(currentWeight: Double) {
        self.currentWeight = currentWeight;
    }
    
    func addCurrentSleep(currentSleep: Int) {
        self.currentSleep = currentSleep;
    }
    
    func setSleepQuality(currentSleepQuality: Int) {
        self.currentSleepQuality = currentSleepQuality;
    }
    
    func addFoodCalories(addCalories: Int) {
        self.currentFoodCalories += addCalories;
    }
    
    func addWaterIntake(addWater: Int) {
        self.currentWater = addWater;
    }
    
    


    func getLatestEntry() -> Entry? {
        
        
        if (DailyEntries.count == 0) {
            return nil;
            // should trigger upon first use.
        }
        
        
        
        return DailyEntries[DailyEntries.count - 1];
    
    }
    
    
    func getEntryList(goBack: Int) -> [Entry]? {
        
        // Loops backwards from the DailyEntries Array goBack amount of times, as long as it is valid
        
        // views will be 1w, 2w, 4w, 3m, 6m, 1y
        
        if (DailyEntries.count == 0) {
            return nil;
        }
        
        // grab array of entry objects from time to now, specified in function parameter.
        
        var returnArray: [Entry] = [];
        // alternatively, simply loop back to time
        let parameter = 2;
        var counter = 0;
        
        while (counter <= parameter && DailyEntries.count - 1 - counter >= 0) {
            returnArray[counter] = DailyEntries[DailyEntries.count - 1 - counter];
            counter += 1;
        }
        
        return returnArray;
    }
    
    
    func addEntry () {
        
        self.DailyEntries[DailyEntries.count] = Entry.init(today: Date(), weight: currentWeight, sleep: currentSleep,
        foodCalories: currentFoodCalories, water: currentWater, sleepQuality: currentSleepQuality, activeCalories: currentActiveCalories);
        
        // if it is the end of the day. reset the current variables.
        resetCurrentVariables();
        
    }
    
    
    func resetCurrentVariables() {
        self.currentSleep = 0;
        self.currentWater = 0;
        self.currentWeight = 0;
        self.currentFoodCalories = 0;
        self.currentSleepQuality = 0;
        self.currentFoodCalories = 0;
    }
    

    
    
    
    
    
    
    
}
