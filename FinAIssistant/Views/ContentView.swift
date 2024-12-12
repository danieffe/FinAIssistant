//
//  ContentView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var budgetManager = BudgetManager()

    var body: some View {
        TabView {
            DashboardView()
                .environmentObject(budgetManager)
                .tabItem {
                    Label("Dashboard", systemImage: "chart.pie.fill")
                }

            SettingsView()
                .environmentObject(budgetManager)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .accentColor(.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




