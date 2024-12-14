//
//  Transaction.swift
//  FinAIssistant
//
//  Created by Daniele Fontana on 09/12/24.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
    let date: String
    let description: String
}


