//
//  Item.swift
//  Money Tracker
//
//  Created by Андрей Логвинов on 1/9/24.
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
