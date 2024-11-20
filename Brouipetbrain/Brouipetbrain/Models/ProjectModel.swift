//
//  ProjectModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 09.11.2024.
//

import Foundation

struct ProjectModel: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name, description: String
    var date: Date
    var price: Int
    var isDone: Bool
    
    var income: [Int] = []
    var costs: [Int] = []
    
    var totalIncome: Int {
        income.reduce(0) {$0 + $1}
    }
    
    var totalCosts: Int {
        costs.reduce(0) {$0 + $1}
    }
    
    var profit: Int {
        totalIncome - totalCosts
    }
}
