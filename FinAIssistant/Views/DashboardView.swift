//
//  DashboardView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 05/12/24.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var budgetManager: BudgetManager  // Usa EnvironmentObject
    @State private var showNewExpenseSheet = false // Stato per il foglio delle spese
    @State private var showNewCategorySheet = false // Stato per il foglio delle categorie
    @State private var showCalendarPopup = false  // Stato per il popup del calendario
    @State private var selectedMonth = Date()     // Stato per la data selezionata

    // Funzione per ottenere la data nel formato "THURSDAY, 12 DEC"
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM"
        return formatter.string(from: Date()).uppercased() // Per ottenere il formato richiesto con la data in maiuscolo
    }

    // Funzione per formattare mese e anno dalla data
    func formattedMonthYear(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    var body: some View {
        ZStack {  // ZStack per sovrapporre la notifica sopra la dashboard
            NavigationView {
                ScrollView { // Unica ScrollView per tutto il contenuto
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
                                        Button(action: {
                                            showCalendarPopup.toggle() // Mostra o nasconde il popup
                                        }) {
                                            Image(systemName: "calendar")
                                                .foregroundColor(.blue)
                                        }
                                        .popover(isPresented: $showCalendarPopup) {
                                            VStack {
                                                Text("Select Month")
                                                    .font(.headline)
                                                    .padding()

                                                DatePicker(
                                                    "",
                                                    selection: $selectedMonth,
                                                    in: ...Date(), // Limita la selezione a oggi e date precedenti
                                                    displayedComponents: [.date]
                                                )
                                                .datePickerStyle(GraphicalDatePickerStyle())
                                                .labelsHidden()
                                                .frame(maxWidth: 300, maxHeight: 300)

                                                Button("Close") {
                                                    showCalendarPopup = false
                                                }
                                                .padding()
                                            }
                                            .frame(width: 350, height: 400)
                                        }

                                        Text(formattedMonthYear(from: selectedMonth))
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
                        .padding(.bottom, 20) // Spazio extra sotto il grafico

                        Text("Categories")
                            .font(.headline)
                            .padding([.horizontal])
                            .padding(.top, -10) // Spazio extra sopra "Categories"
                            .frame(maxWidth: .infinity, alignment: .leading)

                        VStack(spacing: 10) {
                            ForEach(budgetManager.categories) { category in
                                CategoryCardView(category: category)
                                    .environmentObject(budgetManager) // Passa l'oggetto EnvironmentObject
                            }
                        }
                        .padding([.horizontal, .bottom]) // Padding per le categorie
                    }
                    .padding(.top, -11)
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
            
            // Mostra la notifica in alto quando showToast è true
            if budgetManager.showToast {
                ToastView()
                    .transition(.move(edge: .top)) // Muove la notifica dall'alto
                    .padding(.top, 60) // Posiziona la notifica più in alto
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(BudgetManager()) // Passa l'oggetto BudgetManager come EnvironmentObject
    }
}

