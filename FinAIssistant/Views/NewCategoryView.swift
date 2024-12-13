//
//  NewCategoryView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 13/12/24.
//

import SwiftUI

struct NewCategoryView: View {
    @Binding var showNewCategorySheet: Bool
    @State private var categoryName = ""
    @State private var selectedColor: Color = .blue

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category Details")) {
                    TextField("Category Name", text: $categoryName)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled(false)

                    // Color picker per la selezione del colore
                    ColorPicker("Select Color", selection: $selectedColor)
                        .padding(.top, 5)
                }
            }
            .navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showNewCategorySheet = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Azione per salvare la nuova categoria
                        print("Category Saved: \(categoryName), Color: \(selectedColor)")
                        showNewCategorySheet = false
                    }
                    .disabled(categoryName.isEmpty)
                }
            }
        }
    }
}

struct NewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewCategoryView(showNewCategorySheet: .constant(true))
    }
}
