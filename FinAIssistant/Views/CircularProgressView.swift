//
//  CircularProgressView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 05/12/24.
//

import SwiftUI

struct CircularProgressView: View {
    let categories: [ProgressCategory]
    @State private var animatedProgress: [CGFloat]

    init(categories: [ProgressCategory]) {
        self.categories = categories
        _animatedProgress = State(initialValue: categories.map { _ in CGFloat(0) }) // inizializza i progressi animati a 0
    }

    var body: some View {
        ZStack {
            // Cerchio di base per ogni categoria con un gradiente più chiaro
            ForEach(0..<categories.count, id: \.self) { index in
                let category = categories[index]
                let lighterColor = category.color.opacity(0.5) // Un colore più chiaro ma meno trasparente
                
                // Cerchio non colorato con gradiente meno chiaro
                Circle()
                    .trim(from: 0, to: 1) // Cerchio intero non colorato
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [lighterColor, lighterColor.opacity(0)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90)) // Inizia il riempimento da ore 12
                    .frame(width: CGFloat(200 - (index * 30)), height: CGFloat(200 - (index * 30)))
                
                // Cerchio progressivo per ogni categoria
                Circle()
                    .trim(from: 0, to: animatedProgress[index]) // Usa l'animazione progressiva
                    .stroke(
                        category.color,
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90)) // Inizia il riempimento da ore 12
                    .frame(width: CGFloat(200 - (index * 30)), height: CGFloat(200 - (index * 30)))
                    .onAppear {
                        // Avvia l'animazione quando la vista appare
                        withAnimation(.easeInOut(duration: 1.5)) {
                            animatedProgress[index] = category.progress
                        }
                    }
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(categories: [
            ProgressCategory(name: "Food", progress: 0.3, color: .yellow),
            ProgressCategory(name: "Transportation", progress: 0.2, color: .orange),
            ProgressCategory(name: "Healthcare", progress: 0.4, color: .green),
            ProgressCategory(name: "Housing", progress: 0.1, color: .red),
            ProgressCategory(name: "Entertainment", progress: 0.6, color: .blue),
            ProgressCategory(name: "Miscellaneous", progress: 0.5, color: .purple)
        ])
    }
}

