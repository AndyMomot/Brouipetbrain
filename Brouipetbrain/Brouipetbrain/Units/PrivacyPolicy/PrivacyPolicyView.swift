//
//  PrivacyPolicyView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 20.11.2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var rootVM: RootContentView.RootContentViewModel
    
    var body: some View {
        ZStack {
            Colors.darkBlue.swiftUIColor
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Asset.ppLogo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 20)
                    .padding(.horizontal, 88)
                
                VStack(spacing: 30) {
                    HStack(spacing: 0) {
                        Asset.ppDoor.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                        
                        Text("Confidential data")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 25))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                        
                    }
                    .padding(.horizontal, 20)
                    .background(Colors.greenCustom.swiftUIColor)
                    .cornerRadius(55, corners: .allCorners)
                    
                    HStack(spacing: 0) {
                        Asset.ppDataBase.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                        
                        Text("System protection")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 25))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                        
                    }
                    .padding(.horizontal, 20)
                    .background(Colors.greenCustom.swiftUIColor)
                    .cornerRadius(55, corners: .allCorners)
                }
                .padding(.horizontal, 32)
                
                Button {
                    viewModel.showPrivacyPolicy.toggle()
                } label: {
                    Text("I have read the privacy policy")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 18))
                        .underline(color: Colors.greenCustom.swiftUIColor)
                        
                }
                
                Spacer()
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 55)
                        .fill(Colors.greenCustom.swiftUIColor)
                    
                    VStack(spacing: 0) {
                        NextButton(
                            title: "Next",
                            bgColor: .white,
                            textColor: Colors.greenCustom.swiftUIColor
                        ) {
                            DispatchQueue.main.async {
                                withAnimation {
                                    rootVM.setFlow(.main)
                                }
                            }
                        }
                        .frame(height: 56)
                        .padding(.horizontal, 100)
                        .offset(y: -28)
                        Spacer()
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .sheet(isPresented: $viewModel.showPrivacyPolicy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyUrl)
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
