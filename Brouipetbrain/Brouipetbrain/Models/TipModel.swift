//
//  TipModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 13.11.2024.
//

import Foundation

struct TipModel: Identifiable {
    private(set) var id = UUID().uuidString
    var title: String
    var content: [String]
}
