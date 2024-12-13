//
//  BudgetManager.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 08/12/24.
//

import SwiftUI

class BudgetManager: ObservableObject {
    @Published var categories: [Category] = [
        Category(name: "Food", color: .yellow, iconName: "fork.knife"), // Posate
        Category(name: "Transportation", color: .orange, iconName: "airplane"), // Aereo
        Category(name: "Healthcare", color: .green, iconName: "heart.fill"), // Cuore (per la salute)
        Category(name: "Housing", color: .red, iconName: "house.fill"), // Casa
        Category(name: "Entertainment", color: .blue, iconName: "tv.fill"), // TV (per intrattenimento)
        Category(name: "Miscellaneous", color: .purple, iconName: "ellipsis.circle.fill") // Miscellaneous (Ellisse)
    ]
    
    @Published var transactions: [Transaction] = [
        Transaction(category: "Food", amount: 45.50, date: "Dec 1", description: "Supermarket"),
        Transaction(category: "Transportation", amount: 20.00, date: "Dec 2", description: "Taxi Fare"),
        Transaction(category: "Healthcare", amount: 80.00, date: "Dec 3", description: "Doctor Visit"),
        Transaction(category: "Housing", amount: 800.00, date: "Dec 4", description: "Monthly Rent"),
        Transaction(category: "Entertainment", amount: 50.00, date: "Dec 5", description: "Cinema Ticket"),
        Transaction(category: "Miscellaneous", amount: 30.00, date: "Dec 6", description: "Gift")
    ]
    
    @Published var budgetLimits: [String: Double] = [
        "Food": 500,
        "Transportation": 150,
        "Healthcare": 200,
        "Housing": 1000,
        "Entertainment": 300,
        "Miscellaneous": 100
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











