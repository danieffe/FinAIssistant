//
//  ToastView.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 14/12/24.
//

import SwiftUI

struct ToastView: View {
    var body: some View {
        Text("Transaction has been saved successfully!")
            .font(.subheadline)
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal)
            .transition(.move(edge: .bottom))
    }
}

#Preview {
    ToastView()
}
