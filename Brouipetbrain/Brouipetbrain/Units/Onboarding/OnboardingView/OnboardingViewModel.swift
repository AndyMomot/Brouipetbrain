//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        @Published var showAuthView = false
        
        let privacyPolicyURL = URL(string: "https://google.com")
        
        func showMainFlow(rootViewModel: RootContentView.RootContentViewModel) {
            DispatchQueue.main.async {
                rootViewModel.setFlow(.main)
            }
        }
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboardPerson1.name
            case .second:
                return Asset.onboardPerson2.name
            case .third:
                return Asset.onboardPerson3.name
            }
        }
        
        var title: String {
            switch self {
            case .first:
                return "Our app provides businesses with quick, tailored solutions during tough times. With tools to calculate service costs, employee payments, and expert consultations, you can stay focused on your business's recovery."
            case .second:
                return "Receive detailed financial verdicts based on comprehensive data analysis. Brouipetbrain helps you make informed decisions, ensuring your business moves toward self-sufficiency and long-term success."
            case .third:
                return "Empower your team with our educational module to help junior specialists grow. Workshops and learning plans provide resources that foster growth in crisis management."
            }
        }
        
        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
        
        var max: Int {
            OnboardingItem.allCases.last?.rawValue ?? 0
        }
    }
}
