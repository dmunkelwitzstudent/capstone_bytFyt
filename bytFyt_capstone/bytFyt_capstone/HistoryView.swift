//
//  History.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/27/23.
//
import Foundation
import SwiftUI
import Charts
import SwiftData

// Define color scheme
struct AppColorScheme {
  static let backgroundColor = Color.gray
  static let accentColor = Color.white
  static let textColor = Color.white
}

struct HistoryView: View {
    
    @Environment(\.modelContext) private var modelContext;
    @Query private var users: [User];
    
    @Query private var entries: [Entry];
    
    
    
    
    @State private var currentTag = "sleep";
    var body: some View {
        
        var entries = [
        
            
            
            Entry.init(today: Date() - (86400 * 12), weight: 200, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 11), weight: 199, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 10), weight: 198, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 9), weight: 197, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 8), weight: 190, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 7), weight: 200, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 6), weight: 199, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 5), weight: 198, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 4), weight: 197, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 3), weight: 190, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 2), weight: 185, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55),
            Entry.init(today: Date() - (86400 * 1), weight: 182, sleep: 8, foodCalories: 12, water: 33, sleepQuality: 44, activeCalories: 55)
            

        ];
        

        
        VStack {
                Text("\(currentTag)")
  
                Chart {
                    ForEach(entries, id: \.Date) { entry in
                        
                        if (currentTag == "sleep") {
                            BarMark(
                                x: .value("Day",  getFormat(inputDate: entry.Date)),
                                y: .value("Sleep", entry.Sleep)
                            )
                        } else if (currentTag == "weight") {
                            BarMark(
                                x: .value("Day",  getFormat(inputDate: entry.Date)),
                                y: .value("Weight", entry.Weight)
                            )
                        }
                        
                        else if (currentTag == "sleepquality") {
                            BarMark(
                                x: .value("Day",  getFormat(inputDate: entry.Date)),
                                y: .value("Sleep Quality", entry.SleepQuality)
                            )
                        }
                        
                        else if (currentTag == "water") {
                            BarMark(
                                x: .value("Day",  getFormat(inputDate: entry.Date)),
                                y: .value("Water", entry.WaterIntake)
                            )
                        }
                        else if (currentTag == "food") {
                            BarMark(
                                x: .value("Day",  getFormat(inputDate: entry.Date)),
                                y: .value("Food", entry.FoodCalories)
                            )
                        }

                        
                        else {
                            BarMark(
                                x: .value("Day",  getFormat(inputDate: entry.Date)),
                                y: .value("Active", entry.ActiveCalories)
                            )
                        }
                        

                    }
                }
        
            
            HStack {
                Button("Sleep") {
                    currentTag = "sleep"
                    
                }
                Button("Weight") {
                    currentTag = "weight"
                }
                
                Button("Food") {
                    currentTag = "food"
                    
                }
                Button("Sleepquality") {
                    currentTag = "sleepquality"
                }
                
                Button("Water") {
                    currentTag = "water"
                    
                }
                Button("Active ") {
                    currentTag = "active"
                }
                
                Button("1w") {
                    
                }
                
            }
            
        }
        
        

    }
    
    func getFormat(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: inputDate)
        
    }
    
    
    func getEntryList(goBack: Int, entryList: [Entry]) -> [Entry]? {

        // Loops backwards from the DailyEntries Array goBack amount of times, as long as it is valid

        // views will be 1w, 2w, 4w, 3m, 6m, 1y
        var returnArray: [Entry] = [];

        if (entryList.count == 0) {
            return nil;
        }


        var loopCounter: Int = 0;
        //while () {
            //
            //returnArray[loopCounter] = Entry.init(today: (Date() - 86), weight: 0, sleep: 0, foodCalories: 0, water: 0, sleepQuality: 0, activeCalories: 0)
       // }

        // grab array of entry objects from time to now, specified in function parameter.


//        // alternatively, simply loop back to time
//        let parameter = 2;
//        var counter = 0;
//
//        while (counter <= parameter && DailyEntries.count - 1 - counter >= 0) {
//            returnArray[counter] = DailyEntries[DailyEntries.count - 1 - counter];
//            counter += 1;
//        }

        return returnArray;
    }
    
}
