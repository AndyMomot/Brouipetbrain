//
//  TabBarViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation

extension TabBar {
    final class TabBarViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.home.rawValue
        @Published var showTabBar = true
        
        func showTabBar(show: Bool) {
            DispatchQueue.main.async { [weak self] in
                self?.showTabBar = show
            }
        }
    }
}

extension TabBar {
    enum TabBarSelectionView: Int {
        case home = 0
        case staff
        case analytics
        case challenges
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        var imageName: String
    }
}
