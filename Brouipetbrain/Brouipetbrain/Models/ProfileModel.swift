//
//  ProfileModel.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 11.11.2024.
//

import Foundation

struct ProfileModel: Codable, Equatable {
    private(set) var id = UUID().uuidString
    var userName: String
}
