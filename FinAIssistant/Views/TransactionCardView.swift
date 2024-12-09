//
//  TransactionCardView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 09/12/24.
//

import SwiftUI

struct TransactionCardView: View {
    let transaction: Transaction
    
    private let categoryColors: [String: Color] = [
        "Grocery": .yellow,
        "Entertainment": .green,
        "Rent": .red,
        "Bills": .blue,
        "Transport": .orange
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(transaction.category)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Text("$\(transaction.amount, specifier: "%.2f")")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(transaction.date)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(width: 180, height: 150)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(categoryColors[transaction.category] ?? .gray)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
        )
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCardView(transaction: Transaction(category: "Grocery", amount: 45.50, date: "Dec 1"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

