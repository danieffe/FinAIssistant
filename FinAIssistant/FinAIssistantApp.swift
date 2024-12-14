//
//  FinAIssistantApp.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 05/12/24.
//

import SwiftUI

@main
struct YourApp: App {
    @StateObject private var budgetManager = BudgetManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(budgetManager)
        }
    }
}



