//
//  ChartModel.swift
//  Money Tracker
//
//  Created by Андрей Логвинов on 1/25/24.
//

import Foundation

struct ChartGroup: Identifiable {
    let id = UUID()
    var date: Date
    var categories: [ChartCategory]
    var totalIncome: Double
    var totalEExpense: Double
}

struct ChartCategory: Identifiable {
    let id = UUID()
    var totalValue: Double
    var category: Category
}
