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
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Text("Expenses Progress")
                            .font(.headline)
                            .padding([.top, .horizontal])
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityLabel("Expenses Progress, shows the overall progress of your spending across all categories.")

                        // Card per il grafico e le uscite mensili
                        VStack {
                            HStack {
                                // Grafico
                                CircularProgressView(categories: budgetManager.categories.map {
                                    ProgressCategory(
                                        name: $0.name,
                                        progress: budgetManager.getProgress(forCategory: $0.name),
                                        color: $0.color
                                    )
                                })
                                .frame(height: 200)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accessibilityLabel("Spending progress chart for all categories.")

                                // Informazioni sulle uscite mensili
                                VStack(alignment: .leading) {
                                    Text("Total Monthly Expenses")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .accessibilityLabel("Total monthly expenses overview.")

                                    Text("€0.00") // Placeholder per l'importo
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                        .accessibilityLabel("Total expenses amount is zero euros.")

                                    Spacer()

                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.blue)
                                        Text("December 2024") // Mese corrente
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                            .accessibilityLabel("Current month is December 2024.")
                                    }
                                }
                                .padding(.leading, 10)
                                .frame(maxWidth: 120, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                        )
                        .padding(.horizontal)

                        Text("Categories")
                            .font(.headline)
                            .padding([.horizontal])
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Grande card scrollabile che contiene le categorie
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(budgetManager.categories) { category in
                                    CategoryCardView(category: category)
                                        .environmentObject(budgetManager)
                                }
                            }
                        }
                        .frame(height: geometry.size.height - 280) // Imposta l'altezza in base alle dimensioni dello schermo
                        .padding([.horizontal, .bottom])
                    }
                    .padding(.top, -11)
                }
            }
            .navigationTitle("Welcome Daniele")
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
        .navigationViewStyle(.stack) // Forza lo stile stack su iPad
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

