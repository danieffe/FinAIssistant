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
                VStack {
                    Text("Expenses Progress")
                        .font(.headline)
                        .padding([.top, .horizontal]) // Rimosso il padding dal basso
                        .frame(maxWidth: .infinity, alignment: .leading) // Allineato a sinistra
                    
                    // Grafico con cerchi concentrici
                    CircularProgressView(categories: budgetManager.categories.map {
                        ProgressCategory(
                            name: $0.name,
                            progress: budgetManager.getProgress(forCategory: $0.name),
                            color: $0.color
                        )
                    })
                    .frame(height: 300)
                    .padding(.vertical, 10) // Spazio sopra e sotto il grafico
                    .offset(x: -70) // Sposta il grafico leggermente a sinistra
                    
                    // Titolo delle categorie (allineato a sinistra)
                    Text("Categories")
                        .font(.headline)
                        .padding([.horizontal]) // Solo padding orizzontale
                        .frame(maxWidth: .infinity, alignment: .leading) // Allineato a sinistra
                    
                    // Grande card scrollabile che contiene le categorie
                    ScrollView {
                        VStack(spacing: 10) { // Spazio ridotto tra le card
                            ForEach(budgetManager.categories) { category in
                                CategoryCardView(category: category)
                                    .environmentObject(budgetManager)
                            }
                        }
                    }
                    .frame(height: 350) // Altezza della card
                    .padding([.horizontal, .bottom]) // Rimosso padding in alto
                }
                .padding(.top, -11) // Spazio aggiuntivo solo in cima per avvicinare il contenuto
            }
            .navigationTitle("Welcome Daniele") // Nuovo titolo della nav
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            // Azione per aggiungere una nuova spesa
                        }) {
                            Label("New Expense", systemImage: "plus.circle")
                        }
                        Button(action: {
                            // Azione per aggiungere una nuova categoria
                        }) {
                            Label("New Category", systemImage: "folder.badge.plus")
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
