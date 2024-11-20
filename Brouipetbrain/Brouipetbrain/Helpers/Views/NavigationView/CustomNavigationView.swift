//
//  CustomNavigationView.swift
//  Preimiplawood
//
//  Created by Andrii Momot on 07.11.2024.
//

import SwiftUI

struct CustomNavigationView: View {
    var image: UIImage
    var nickname: String
    var showSearch = true
    var action: ((Action) -> Void)?
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    // Image
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 67, height: 67)
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 65, height: 65)
                            .clipShape(Circle())
                            .clipped()
                    }
                    .onTapGesture {
                        action?(.onProfile)
                    }
                    
                    // Nickname
                    Text("Dzień dobry, ")
                        .foregroundColor(.white)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 12)) +
                    Text(nickname)
                        .foregroundColor(.blue)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 12))
                    
                    Spacer()
                    
                    // Search
                    if showSearch {
                        Button {
                            action?(.onShowSearch)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 24, height:  24)
                            
                        }
                    }
                }
                .padding(.top, geo.safeAreaInsets.top + 10)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
                .background(Colors.darkBlue.swiftUIColor)
                .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

extension CustomNavigationView {
    enum Action {
        case onProfile
        case onShowSearch
    }
}

#Preview {
    VStack {
        CustomNavigationView(image: Asset.preloaderBg.image,
                             nickname: "Nickname") { _ in }
        Spacer()
    }
}
