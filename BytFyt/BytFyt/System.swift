//
//  System.swift
//  bytFyt_capstone
//
//  Created by Daniel Munkelwitz on 12/5/23.
//

import Foundation
import SwiftData

    // This class represents various helper functions
    class System {

        
        // getFormat returns the current day in a specific format.
        // for example, passing in Date() at the time of writing this comment would
        // return 12/10
        static func getFormat(inputDate: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/dd"
            dateFormatter.calendar = Calendar(identifier: .gregorian)
            return dateFormatter.string(from: inputDate)
            
        }

        // These Metric and Imperial functions are for converting data back and forth.
        
        static func convertMetricHeight(inputHeight: Double) -> Double{
            return Double(round(Double(inputHeight) * 0.3937));
        }
        
        static func convertImperialHeight(inputHeight: Double) -> Double {
            return Double(round(Double(inputHeight) * 2.54));
        }
        
        static func convertMetricWeight(inputWeight: Double) -> Double{
            return (inputWeight / 0.453592);
        }
        
        static func convertImperialWeight(inputWeight: Double) -> Double{
            return (inputWeight / 2.20462);
        }
        
        static func convertImperialWater(waterAmount: Double) -> Double{
            return (waterAmount * 29.574);
        }
        
        static func convertMetricWater(waterAmount: Double) -> Double {
            return (waterAmount / 29.574);
        }



    }

