//
//  BudgetManager.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 08/12/24.
//

import SwiftUI

class BudgetManager: ObservableObject {
    @Published var categories: [Category] = [
        Category(name: "Grocery", color: .yellow),
        Category(name: "Entertainment", color: .green),
        Category(name: "Rent", color: .red),
        Category(name: "Bills", color: .blue),
        Category(name: "Transport", color: .orange)
    ]
    
    @Published var transactions: [Transaction] = [
        Transaction(category: "Grocery", amount: 45.50, date: "Dec 1"),
        Transaction(category: "Entertainment", amount: 120.00, date: "Dec 2"),
        Transaction(category: "Rent", amount: 800.00, date: "Dec 3"),
        Transaction(category: "Bills", amount: 60.00, date: "Dec 4"),
        Transaction(category: "Transport", amount: 20.00, date: "Dec 5")
    ]
    
    @Published var budgetLimits: [String: Double] = [
        "Grocery": 500,
        "Entertainment": 300,
        "Rent": 1000,
        "Bills": 200,
        "Transport": 150
    ]
    
    func getProgress(forCategory category: String) -> CGFloat {
        guard let limit = budgetLimits[category] else { return 0.0 }
        let totalSpent = transactions
            .filter { $0.category == category }
            .map { $0.amount }
            .reduce(0, +)
        return CGFloat(min(totalSpent / limit, 1.0))
    }
}



