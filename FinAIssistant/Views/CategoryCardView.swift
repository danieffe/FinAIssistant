//
//  CategoryCardView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 11/12/24.
//

import SwiftUI

struct CategoryCardView: View {
    let category: Category
    @Binding var selectedCategory: String?
    @EnvironmentObject var budgetManager: BudgetManager
    @State private var isExpanded = false // Gestisce lo stato di espansione
    
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
                
                // Mostra l'animazione solo se la card è selezionata
                if isExpanded {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(budgetManager.transactions.filter { $0.category == category.name }) { transaction in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(transaction.description) // Mostra la descrizione
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("$\(transaction.amount, specifier: "%.2f")") // Mostra l'importo accanto
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                                Text(transaction.date) // Mostra la data sotto
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding(.horizontal)
                        }
                    }
                    .transition(.move(edge: .bottom)) // Transizione in espansione verso il basso
                    .animation(.easeInOut, value: isExpanded)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(category.color)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
            )
            .onTapGesture {
                // Cambia lo stato di espansione
                withAnimation {
                    isExpanded.toggle()
                }
            }
        }
        .padding(.vertical, 5) // Spazio tra le card
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(category: Category(name: "Food", color: .yellow), selectedCategory: .constant(nil))
            .environmentObject(BudgetManager())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
