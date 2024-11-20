//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $viewModel.selection) {
            Text("Home")
                .tag(TabBarSelectionView.home.rawValue)
                .environmentObject(viewModel)
            
            Text("Staff")
                .tag(TabBarSelectionView.staff.rawValue)
            
            Text("Analytics")
                .tag(TabBarSelectionView.analytics.rawValue)
                .environmentObject(viewModel)
            
            Text("Challenges")
                .tag(TabBarSelectionView.challenges.rawValue)
                .environmentObject(viewModel)
        }
        .overlay {
            if viewModel.showTabBar {
                VStack {
                    Spacer()
                    TabBarCustomView(selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.12)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

#Preview {
    TabBar()
}
