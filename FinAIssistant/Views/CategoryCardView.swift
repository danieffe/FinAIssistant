//
//  CategoryCardView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 11/12/24.
//

import SwiftUI

struct CategoryCardView: View {
    let category: Category
    @EnvironmentObject var budgetManager: BudgetManager

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                // Icona e nome della categoria
                HStack {
                    Image(systemName: category.iconName) // Icona SF associata alla categoria
                        .foregroundColor(.white)
                        .font(.title2) // Imposta la dimensione dell'icona

                    Text(category.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Category \(category.name), displays transactions for the \(category.name) category") // Legge la categoria con una descrizione
                }

                // Limite del budget
                Text("Budget Limit: \(Int(budgetManager.budgetLimits[category.name] ?? 0)) €")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityLabel("Budget Limit for \(category.name) Category is \(Int(budgetManager.budgetLimits[category.name] ?? 0))") // Legge il limite del budget

                // Mostra direttamente le transazioni
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(budgetManager.transactions.filter { $0.category == category.name }) { transaction in
                        HStack {
                            VStack(alignment: .leading) {
                                // Descrizione della transazione
                                Text(transaction.description)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .accessibilityLabel("Transaction: \(transaction.description)") // Legge la descrizione della transazione

                                // Data della transazione
                                Text(transaction.date)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                                    .accessibilityLabel("Date: \(transaction.date)") // Legge la data
                            }
                            Spacer()
                            // Importo della transazione
                            Text("\(transaction.amount, specifier: "%.2f") €")
                                .font(.body)
                                .foregroundColor(.white)
                                .accessibilityLabel("Amount: \(transaction.amount, specifier: "%.2f") euros") // Legge l'importo
                        }
                        .padding(.horizontal)
                        .accessibilityElement(children: .combine) // Combina la descrizione e l'importo della transazione in un unico elemento
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(category.color)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
            )
        }
        .padding(.vertical, 5) // Spazio tra le card
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(category: Category(name: "Food", color: .yellow, iconName: "fork.knife"))
            .environmentObject(BudgetManager())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
