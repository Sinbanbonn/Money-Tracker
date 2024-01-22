//
//  Transaction.swift
//  Money Tracker
//
//  Created by Андрей Логвинов on 1/18/24.
//

import SwiftUI
import SwiftData

@Model
class Transaction {
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    @Transient
    var color: Color {
        tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
    
    @Transient
    var tint: TintColor {
        tints.first(where: {$0.color == tintColor}) ?? tints[0]
    }
    
    @Transient
    var rawCategory: Category {
        Category.allCases.first(where: { category == $0.rawValue }) ?? Category.expense
    }
    
}
