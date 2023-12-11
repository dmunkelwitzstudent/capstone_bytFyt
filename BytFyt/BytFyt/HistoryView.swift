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
    
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Query private var entries: [Entry]
    @State private var currentTag = "sleep"
    
    // Define the picker options
    private let pickerOptions = ["sleep", "quality", "food", "weight", "water", "active"]
    
    var body: some View {
        
        let main = users[0];
        // testing data for showing history view
        var entries = [
            Entry.init(today: Date() - (86400 * 9), weight: 197, sleep: 6, foodCalories: 2800, water: 54, sleepQuality: 50, activeCalories: 250),
            Entry.init(today: Date() - (86400 * 8), weight: 190, sleep: 8, foodCalories: 1200, water: 61, sleepQuality: 65, activeCalories: 120),
            Entry.init(today: Date() - (86400 * 7), weight: 200, sleep: 8, foodCalories: 1400, water: 22, sleepQuality: 42, activeCalories: 700),
            Entry.init(today: Date() - (86400 * 6), weight: 199, sleep: 7, foodCalories: 2000, water: 99, sleepQuality: 44, activeCalories: 320),
            Entry.init(today: Date() - (86400 * 5), weight: 198, sleep: 7.5, foodCalories: 2190, water: 128, sleepQuality: 98, activeCalories: 50),
            Entry.init(today: Date() - (86400 * 4), weight: 197, sleep: 7.75, foodCalories: 1830, water: 128, sleepQuality: 21, activeCalories: 40),
            Entry.init(today: Date() - (86400 * 3), weight: 190, sleep: 10, foodCalories: 2020, water: 128, sleepQuality: 21, activeCalories: 90),
            Entry.init(today: Date() - (86400 * 2), weight: 185, sleep: 4, foodCalories: 2510, water: 122, sleepQuality: 87, activeCalories: 130),
            Entry.init(today: Date() - (86400 * 1), weight: 182, sleep: 8, foodCalories: 3012, water: 99, sleepQuality: 100, activeCalories: 140)
        ];
        
        VStack {
            Text("\(currentTag.capitalized)")
            
            Chart {
                ForEach(entries, id: \.Date) { entry in
                    
                    if (currentTag == "sleep") {
                        BarMark(
                            x: .value("Day",  System.getFormat(inputDate: entry.Date)),
                            y: .value("Sleep", entry.Sleep)
                        )
                    } else if (currentTag == "weight") {
                        
                        
                        if(main.UseMetric) {
                            BarMark (
                                x: .value("Day",  System.getFormat(inputDate: entry.Date)),
                                y: .value("Weight", System.convertImperialWeight(inputWeight: entry.Weight))
                            )
                        } else {
                            BarMark(
                                x: .value("Day",  System.getFormat(inputDate: entry.Date)),
                                y: .value("Weight", entry.Weight)
                            )
                        }
                        
                    }
                    
                    else if (currentTag == "quality") {
                        BarMark(
                            x: .value("Day",  System.getFormat(inputDate: entry.Date)),
                            y: .value("Sleep Quality", entry.SleepQuality)
                        )
                    }
                    
                    else if (currentTag == "water") {
                        
                        if(main.UseMetric) {
                            
                            BarMark (
                                x: .value("Day",  System.getFormat(inputDate: entry.Date)),
                                y: .value("Water", System.convertImperialWater(waterAmount: entry.WaterIntake))
                            )
                            
                        } else {
                            
                            BarMark(
                                x: .value("Day",  System.getFormat(inputDate: entry.Date)),
                                y: .value("Water", entry.WaterIntake)
                            )
                            
                        }
                        
                    }
                    else if (currentTag == "food") {
                        BarMark(
                            x: .value("Day",  System.getFormat(inputDate: entry.Date)),
                            y: .value("Food", entry.FoodCalories)
                        )
                    }
                    
                    
                    else {
                        BarMark(
                            x: .value("Day",  System.getFormat(inputDate: entry.Date)),
                            y: .value("Active", entry.ActiveCalories)
                        )
                    }
                }
            }
            
            Picker("Select Tag", selection: $currentTag) {
                ForEach(pickerOptions, id: \.self) { option in
                    Text(option.capitalized).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}
