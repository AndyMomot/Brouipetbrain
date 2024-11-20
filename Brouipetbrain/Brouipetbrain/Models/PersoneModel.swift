//
//  PersoneModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 20.11.2024.
//

import Foundation

struct PersonModel: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name, position: String
    var salary: Int
}
