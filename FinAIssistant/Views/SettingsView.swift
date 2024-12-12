//
//  SettingsView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 05/12/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var budgetManager: BudgetManager

    var body: some View {
        NavigationView {
            List {
                ForEach(budgetManager.categories) { category in
                    VStack(alignment: .leading) {
                        Text("\(category.name) Budget Limit")
                            .font(.headline)
                            .foregroundColor(category.color)
                            .accessibilityLabel("\(category.name) budget limit")
                            .accessibilityHint("Tap to adjust the budget for \(category.name)")

                        HStack {
                            Slider(value: Binding(
                                get: { budgetManager.budgetLimits[category.name] ?? 0 },
                                set: { budgetManager.budgetLimits[category.name] = $0 }
                            ), in: 0...2000, step: 10)
                                .accessibilityLabel("Adjust budget for \(category.name)")
                                .accessibilityHint("Drag the slider to set a budget limit")

                            Text("\(Int(budgetManager.budgetLimits[category.name] ?? 0)) €")
                                .frame(width: 60, alignment: .trailing)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .accessibilityLabel("Budget limit value")
                                .accessibilityValue("\(Int(budgetManager.budgetLimits[category.name] ?? 0)) euros")
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Budget Settings")
        }
        .navigationViewStyle(.stack) // Forza lo stile stack su iPad
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let budgetManager = BudgetManager()
        
        return SettingsView()
            .environmentObject(budgetManager)
    }
}
