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
                Text(category.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Budget Limit: \(Int(budgetManager.budgetLimits[category.name] ?? 0)) €")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Mostra direttamente le transazioni
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(budgetManager.transactions.filter { $0.category == category.name }) { transaction in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(transaction.description)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                Text(transaction.date)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            Spacer()
                            Text("\(transaction.amount, specifier: "%.2f") €")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
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
        CategoryCardView(category: Category(name: "Food", color: .yellow))
            .environmentObject(BudgetManager())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


