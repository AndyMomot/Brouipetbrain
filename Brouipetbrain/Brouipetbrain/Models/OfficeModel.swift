//
//  OfficeModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import Foundation

struct OfficeModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String
    var budget, numberOfEmployees: Int
    var description: String
    var isFavorite = false
    var isDeleted = false
}
