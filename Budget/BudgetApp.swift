//
//  BudgetApp.swift
//  Budget
//
//  Created by Edric Antoine on 2025-03-29.
//

import SwiftUI
import SwiftData

@main
struct BudgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [BudgetState.self, Expenditure.self])
        }
    }
}
