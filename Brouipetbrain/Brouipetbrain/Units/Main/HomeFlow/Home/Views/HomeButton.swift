//
//  HomeButton.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct HomeButton: View {
    var imageName: String
    var title: String
    var action: () -> Void
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Color.silver
                    .cornerRadius(20, corners: .allCorners)
                
                VStack(spacing: 6) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: bounds.width * 0.09)
                    
                    Text(title)
                        .foregroundStyle(.black)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                        .multilineTextAlignment(.center)
                }
                .padding(25)
            }
        }
    }
}

#Preview {
    HomeButton(
        imageName: Asset.addOffice.name,
        title: "Create an office"
    ) {}
        .frame(width: 90)
}
