//
//  System.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 12/5/23.
//

import Foundation
import SwiftData




    class System {




//        static func addEntry() {
//
//             //var main = users[0];
//
////              var newEntry = Entry(today: Date(), weight: main.currentWeight, sleep: main.currentSleep, foodCalories: main.currentFoodCalories, water: main.currentWater, sleepQuality: main.currentSleepQuality, activeCalories: main.currentActiveCalories)
////
////
////             modelContext.insert(newEntry);
//
//            print("addEntry called")
//
//        }
//
        static func getFormat(inputDate: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "mm"
            dateFormatter.calendar = Calendar(identifier: .gregorian)
            return dateFormatter.string(from: inputDate)
            
        }
        
        static func convertMetricHeight(inputHeight: Double) -> Double{
            return Double(round(Double(inputHeight) * 2.54));
        }
        
        static func convertImperialHeight(inputHeight: Double) -> Double {
            return Double(round(Double(inputHeight) * 0.3937));
        }
        
        static func convertMetricWeight(inputWeight: Double) -> Double{
            return (inputWeight / 0.453592);
        }
        
        static func convertImperialWeight(inputWeight: Double) -> Double{
            return (inputWeight / 2.20462);
        }
        
        static func convertImperialWater(waterAmount: Double) -> Double{
            return (waterAmount * 29.5735);
        }
        
//        func getLatestEntry() -> Entry? {
//
//
//            if (DailyEntries.count == 0) {
//                return nil;
//                // should trigger upon first use.
//            }
//
//
//
//            return DailyEntries[DailyEntries.count - 1];
//
//        }
//
//
//        func getEntryList(goBack: Int) -> [Entry]? {
//
//            // Loops backwards from the DailyEntries Array goBack amount of times, as long as it is valid
//
//            // views will be 1w, 2w, 4w, 3m, 6m, 1y
//
//            if (DailyEntries.count == 0) {
//                return nil;
//            }
//
//
//
//            // grab array of entry objects from time to now, specified in function parameter.
//
//            var returnArray: [Entry] = [];
//            // alternatively, simply loop back to time
//            let parameter = 2;
//            var counter = 0;
//
//            while (counter <= parameter && DailyEntries.count - 1 - counter >= 0) {
//                returnArray[counter] = DailyEntries[DailyEntries.count - 1 - counter];
//                counter += 1;
//            }
//
//            return returnArray;
//        }


    }

