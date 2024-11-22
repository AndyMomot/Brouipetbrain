//
//  ChallengesView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 22.11.2024.
//

import SwiftUI

struct ChallengesView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var tabBarVM: TabBar.TabBarViewModel
    
    var body: some View {
        ZStack {
            Asset.tabBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                VStack(spacing: 8) {
                    BackButtonView()
                    
                    Text("Challenge")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
                }
                
                ChallengesTabView(
                    currentPageIndex: $viewModel.currentPageIndex,
                    items: viewModel.challenges
                )
                
                Spacer()
                
                HStack(spacing: 0) {
                    Spacer(minLength: 10)
                    ForEach((0..<viewModel.challenges.count), id: \.self) { index in
                        
                        let isCurrent = index == viewModel.currentPageIndex
                        Rectangle()
                            .fill(isCurrent ? .deepBlue : .white)
                            .frame(height: 5)
                        
                        Spacer(minLength: 10)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            withAnimation {
                tabBarVM.showTabBar(show: false)
            }
        }
        .onDisappear {
            withAnimation {
                tabBarVM.showTabBar(show: true)
            }
        }
    }
}

#Preview {
    ChallengesView()
}
