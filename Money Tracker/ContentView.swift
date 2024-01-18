//
//  ContentView.swift
//  Money Tracker
//
//  Created by Андрей Логвинов on 1/9/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Intro visible status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    // Active tab
    @State private var activeTab: Tab = .recents
    
    var body: some View {
        TabView(selection: $activeTab) {
            Recents()
                .tag(Tab.recents)
                .tabItem { Tab.recents.tabContent }
            
            Search()
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
            
            Graphs()
                .tag(Tab.charts)
                .tabItem { Tab.charts.tabContent }
            
            Settings()
                .tag(Tab.settings)
                .tabItem { Tab.settings.tabContent }
        }
        .sheet(isPresented: $isFirstTime, content: {
            InfoScreen()
                .interactiveDismissDisabled()
        })
        
    }
    
}

#Preview {
    ContentView()
}
