//
//  DashboardView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 05/12/24.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var budgetManager = BudgetManager()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Titolo del grafico
                    Text("Progresso delle Spese")
                        .font(.headline)
                        .padding()
                    
                    // Grafico con cerchi concentrici
                    CircularProgressView(categories: budgetManager.categories.map { ProgressCategory(name: $0.name, progress: budgetManager.getProgress(forCategory: $0.name), color: $0.color) })
                        .frame(height: 300)
                        .padding(.bottom, 20)
                    
                    // Titolo delle transazioni
                    Text("Ultime Transazioni")
                        .font(.headline)
                        .padding(.top)
                    
                    // Sezione delle Cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(budgetManager.transactions) { transaction in
                                TransactionCardView(transaction: transaction) // Usa la nuova vista
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
