//
//  CircularProgressView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 05/12/24.
//

import SwiftUI

struct CircularProgressView: View {
    let categories: [ProgressCategory]
    
    var body: some View {
        ZStack {
            // Ogni categoria viene rappresentata come un arco concentricamente più piccolo
            ForEach(0..<categories.count, id: \.self) { index in
                Circle()
                    .trim(from: 0, to: categories[index].progress) // Imposta la porzione da colorare
                    .stroke(
                        categories[index].color,
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90)) // Inizia il riempimento da ore 12
                    .frame(width: CGFloat(200 - (index * 30)), height: CGFloat(200 - (index * 30))) // Dimensione del cerchio
            }
        }
        .frame(width: 200, height: 200) // Dimensione finale del grafico
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(categories: [
            ProgressCategory(name: "Grocery", progress: 0.3, color: .yellow),
            ProgressCategory(name: "Entertainment", progress: 0.2, color: .green),
            ProgressCategory(name: "Rent", progress: 0.4, color: .red),
            ProgressCategory(name: "Bills", progress: 0.1, color: .blue),
            ProgressCategory(name: "Transport", progress: 0.6, color: .orange)
        ])
    }
}
