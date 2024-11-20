//
//  OnboardingView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Asset.onboardBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                VStack(spacing: 0) {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                    
                    VStack(spacing: 60) {
                        HStack(alignment: .top, spacing: 10) {
                            Spacer()
                            ForEach(0..<3) { index in
                                if index == currentPageIndex {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Colors.greenCustom.swiftUIColor)
                                        .frame(width: 8, height: 32)
                                } else {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Colors.darkBlue.swiftUIColor)
                                        .frame(width: 8, height: 17)
                                }
                            }
                            Spacer()
                        }
                        
                        Text(item.title)
                            .foregroundStyle(.black)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 18))
                            .padding(.bottom)
                    }
                    .padding(.vertical, 40)
                    .padding(.horizontal, 15)
                    .background(.white)
                    .cornerRadius(50, corners: [.topLeft, .topRight])
                }
                
                Button {
                    DispatchQueue.main.async {
                        withAnimation {
                            currentPageIndex = item.next.rawValue
                        }
                    }
                    
                    if item == .third {
                        viewModel.showAuthView.toggle()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Further")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 25))
                        Spacer()
                    }
                    .padding(24)
                    .background(Colors.darkBlue.swiftUIColor)
                    .cornerRadius(50, corners: [.bottomLeft, .bottomRight])
                }
                .frame(height: 53)
            }
            .padding(.horizontal, 40)
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
        .fullScreenCover(isPresented: $viewModel.showAuthView) {
            PrivacyPolicyView()
        }
    }
}

#Preview {
    OnboardingView(item: .first, currentPageIndex: .constant(0))
}
