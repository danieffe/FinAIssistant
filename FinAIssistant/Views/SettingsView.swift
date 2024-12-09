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
                        
                        HStack {
                            Slider(value: Binding(
                                get: { budgetManager.budgetLimits[category.name] ?? 0 },
                                set: { budgetManager.budgetLimits[category.name] = $0 }
                            ), in: 0...2000, step: 10)
                            
                            Text("\(Int(budgetManager.budgetLimits[category.name] ?? 0)) €")
                                .frame(width: 60, alignment: .trailing)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Budget Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        // Creiamo un'istanza di BudgetManager per l'anteprima
        let budgetManager = BudgetManager()
        
        return SettingsView()
            .environmentObject(budgetManager) // Passiamo il BudgetManager come EnvironmentObject
    }
}

