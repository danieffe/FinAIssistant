//
//  DashboardView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 05/12/24.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var budgetManager = BudgetManager()
    @State private var selectedCategory: String? = nil
    @State private var showActionSheet = false  // Stato per mostrare l'ActionSheet
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack { // Ridotto lo spazio

                    Text("Expenses Progress")
                        .font(.headline)
                        .padding([.top, .horizontal]) // Rimosso il padding dal basso
                        .frame(maxWidth: .infinity, alignment: .leading) // Allineato a sinistra
                    
                    // Grafico con cerchi concentrici
                    CircularProgressView(categories: budgetManager.categories.map { ProgressCategory(name: $0.name, progress: budgetManager.getProgress(forCategory: $0.name), color: $0.color) })
                        .frame(height: 300)
                        .padding(.vertical, 10) // Spazio ridotto sopra e sotto il grafico
                    
                    // Titolo delle categorie (allineato a sinistra)
                    Text("Categories")
                        .font(.headline)
                        .padding([.horizontal]) // Solo padding orizzontale
                        .frame(maxWidth: .infinity, alignment: .leading) // Allineato a sinistra
                    
                    // Grande card scrollabile che contiene le categorie
                    ScrollView {
                        VStack(spacing: 10) { // Spazio ridotto tra le card
                            ForEach(budgetManager.categories) { category in
                                CategoryCardView(category: category, selectedCategory: $selectedCategory)
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
                    Button(action: {
                        showActionSheet.toggle() // Mostra l'ActionSheet quando cliccato
                    }) {
                        Image(systemName: "plus.circle.fill")  // Icona del tasto "+"
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Select an action"),
                    buttons: [
                        .default(Text("New Expense")) {
                            // Azione per aggiungere una nuova spesa
                            print("New Expense selected")
                        },
                        .default(Text("New Category")) {
                            // Azione per aggiungere una nuova categoria
                            print("New Category selected")
                        },
                        .cancel() // Annulla
                    ]
                )
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
