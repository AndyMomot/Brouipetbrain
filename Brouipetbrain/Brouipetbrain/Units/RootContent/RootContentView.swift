//
//  RootContentView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI

struct RootContentView: View {
    @StateObject private var viewModel = RootContentViewModel()
    private let preloaderView = PreloaderView()
    
    var body: some View {
        Group {
            if viewModel.showPreloader {
                preloaderView
            } else {
                switch viewModel.viewState {
                case .onboarding:
                    OnboardingViewTabView()
                        .environmentObject(viewModel)
                case .main:
                    TabBar()
                        .environmentObject(viewModel)
                }
            }
        }
        .onAppear {
            withAnimation {
                self.viewModel.getFlow()
            }
        }
        .onReceive(preloaderView.onDidLoad) {
            DispatchQueue.main.async {
                withAnimation {
                    self.viewModel.showPreloader.toggle()
                }
            }
        }
    }
}

#Preview {
    RootContentView()
}
