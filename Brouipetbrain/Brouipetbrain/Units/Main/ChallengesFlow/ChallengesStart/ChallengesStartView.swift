//
//  ChallengesStartView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 22.11.2024.
//

import SwiftUI

struct ChallengesStartView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.tabBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 100) {
                        Asset.logo.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 50)
                        
                        VStack(spacing: 25) {
                            Text("Challenge")
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 40))
                            
                            Text("These challenges are designed for both beginners and experienced specialists and cover a wide range of topics, including software development, security, cloud technologies, big data, AI, and system monitoring.")
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                        }
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        
                        NextButton(
                            title: "Start",
                            bgColor: .white,
                            textColor: .deepBlue) {
                                viewModel.showChallenges.toggle()
                            }
                            .frame(height: 55)
                            .padding(.horizontal, 100)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                }
                .scrollIndicators(.never)
            }
            .navigationDestination(isPresented: $viewModel.showChallenges) {
                ChallengesView()
            }
        }
    }
}

#Preview {
    ChallengesStartView()
}
