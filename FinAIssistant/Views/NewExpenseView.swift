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
                        // Azione per salvare la nuova spesa
                        print("Expense Saved: \(description), \(amount)")
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
    }
}

