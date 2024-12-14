//
//  NewExpenseView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 13/12/24.
//

import SwiftUI

struct NewExpenseView: View {
    @Binding var showNewExpenseSheet: Bool
    @State private var description = ""
    @State private var amount = ""

    @EnvironmentObject var budgetManager: BudgetManager // Aggiungi la dipendenza al BudgetManager

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    TextField("Description", text: $description)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(false)

                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("New Expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showNewExpenseSheet = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Aggiungi la transazione usando il BudgetManager
                        if let amountValue = Double(amount), !description.isEmpty {
                            print("Saving transaction with description: \(description) and amount: \(amount)") // Debug: Stampa la descrizione e l'importo
                            budgetManager.addTransaction(description: description, amount: amountValue)
                        }
                        showNewExpenseSheet = false
                    }
                    .disabled(description.isEmpty || amount.isEmpty)
                }
            }
        }
    }
}

struct NewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpenseView(showNewExpenseSheet: .constant(true))
            .environmentObject(BudgetManager()) // Aggiungi l'oggetto BudgetManager all'ambiente
    }
}
