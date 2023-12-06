//
//  Item.swift
//  bytFyt_capstone
//
//  Created by Andrew Thayer on 11/1/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
