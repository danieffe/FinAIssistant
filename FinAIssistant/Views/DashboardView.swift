//
//  DashboardView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 05/12/24.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var budgetManager = BudgetManager()
    @State private var showNewExpenseSheet = false // Stato per il foglio delle spese
    @State private var showNewCategorySheet = false // Stato per il foglio delle categorie

    // Funzione per ottenere la data nel formato "THURSDAY, 12 DEC"
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM"
        return formatter.string(from: Date()).uppercased() // Per ottenere il formato richiesto con la data in maiuscolo
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        // Data sopra il titolo "Welcome Daniele", ridotto il padding per meno spazio
                        Text(formattedDate())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding([.top, .horizontal])
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, -10)

                        Text("Expenses Progress")
                            .font(.headline)
                            .padding([.top, .horizontal])
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, -10)

                        VStack {
                            HStack {
                                CircularProgressView(categories: budgetManager.categories.map {
                                    ProgressCategory(
                                        name: $0.name,
                                        progress: budgetManager.getProgress(forCategory: $0.name),
                                        color: $0.color
                                    )
                                })
                                .frame(height: 200)
                                .frame(maxWidth: .infinity, alignment: .leading)

                                VStack(alignment: .leading) {
                                    Text("Total Monthly Expenses")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)

                                    Text("€0.00")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)

                                    Spacer()

                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.blue)
                                        Text("December 2024")
                                            .font(.footnote)
                                            .foregroundColor(.gray)
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

                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(budgetManager.categories) { category in
                                    CategoryCardView(category: category)
                                        .environmentObject(budgetManager)
                                }
                            }
                        }
                        .frame(height: geometry.size.height - 280)
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
                            showNewExpenseSheet = true
                        }) {
                            Label("New Expense", systemImage: "plus.circle")
                        }
                        Button(action: {
                            showNewCategorySheet = true
                        }) {
                            Label("New Category", systemImage: "folder.badge.plus")
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showNewExpenseSheet) {
                NewExpenseView(showNewExpenseSheet: $showNewExpenseSheet)
            }
            .sheet(isPresented: $showNewCategorySheet) {
                NewCategoryView(showNewCategorySheet: $showNewCategorySheet)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
