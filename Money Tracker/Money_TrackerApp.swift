//
//  Money_TrackerApp.swift
//  Money Tracker
//
//  Created by Андрей Логвинов on 1/9/24.
//

import SwiftUI
import SwiftData

@main
struct Money_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Transaction.self])
    }
}
