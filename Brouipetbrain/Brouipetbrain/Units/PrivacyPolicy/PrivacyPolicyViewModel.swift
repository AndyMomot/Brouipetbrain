//
//  PrivacyPolicyViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 20.11.2024.
//

import Foundation

extension PrivacyPolicyView {
    final class ViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyUrl = URL(string: "https://www.google.com")
    }
}
