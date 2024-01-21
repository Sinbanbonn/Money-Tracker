//
//  Settings.swift
//  Money Tracker
//
//  Created by Андрей Логвинов on 1/18/24.
//

import SwiftUI

struct Settings: View {
    // MARK: - User Properties
    @AppStorage("userName") private var userName: String = ""
    
    // MARK: - App Lock Properties
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("User Name") {
                    TextField("iJustine", text: $userName)
                }
                
                Section("App Lock") {
                    Toggle("Enable App Lock", isOn: $isAppLockEnabled)
                    
                    if isAppLockEnabled {
                        Toggle("Lock when app goes down", isOn: $lockWhenAppGoesBackground)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings()
}
