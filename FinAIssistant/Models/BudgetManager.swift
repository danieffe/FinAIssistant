//
//  BudgetManager.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 08/12/24.
//

import SwiftUI
import CoreML

class BudgetManager: ObservableObject {
    @Published var categories: [Category] = [
        Category(name: "Food", color: .yellow, iconName: "fork.knife"),
        Category(name: "Transportation", color: .orange, iconName: "airplane"),
        Category(name: "Healthcare", color: .green, iconName: "heart.fill"),
        Category(name: "Housing", color: .red, iconName: "house.fill"),
        Category(name: "Entertainment", color: .blue, iconName: "tv.fill"),
        Category(name: "Miscellaneous", color: .purple, iconName: "ellipsis.circle.fill")
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
    
    func categorizeTransaction(description: String, amount: Double) -> String {
        let classifier = try! ExpenseClassifier()  // Carica il modello
        let input = ExpenseClassifierInput(Description: description)  // Crea l'input per il modello
        
        let validCategories = ["Food", "Transportation", "Healthcare", "Housing", "Entertainment", "Miscellaneous"]
        
        do {
            let predictionOutput = try classifier.prediction(input: input)
            let predictedCategory = predictionOutput.Category
            
            if validCategories.contains(predictedCategory) {
                return predictedCategory
            } else {
                return "Miscellaneous"
            }
        } catch {
            print("Errore durante la previsione: \(error)")
            return "Miscellaneous"
        }
    }
    
    func addTransaction(description: String, amount: Double) {
        // Usa il modello per determinare la categoria della transazione
        let category = categorizeTransaction(description: description, amount: amount)
        
        // Crea la transazione e aggiungila all'elenco
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        let date = dateFormatter.string(from: Date())
        
        let newTransaction = Transaction(category: category, amount: amount, date: date, description: description)
        
        // Aggiungi la nuova transazione alla lista delle transazioni
        DispatchQueue.main.async {
            self.transactions.append(newTransaction)
        }

        print("Transaction added: \(newTransaction)") // Debug: Stampa la nuova transazione
    }
}

