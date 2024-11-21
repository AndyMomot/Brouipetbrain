//
//  OfficeDefaultView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct OfficeDefaultView: View {
    var budget: Int
    var isFavorite: Bool
    var action: (_ isFavorite: Bool) -> Void
    
    @State private var title = ""
    
    var body: some View {
        VStack(spacing: 50) {
            HStack {
                Spacer()
                Text("\(budget)".toNumberFormat())
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 40))
                Spacer()
                Rectangle()
                    .fill(.white)
                    .frame(width: 4)
                Spacer()
                Text("Company budget")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                Spacer()
            }
            .padding(14)
            .frame(maxHeight: 85)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white, lineWidth: 3)
            }
            
            VStack(spacing: 20) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                
                Button {
                    action(!isFavorite)
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(height: 30)
                        Spacer()
                    }
                    .padding(5)
                    .background(isFavorite ? .orangeCustom : .clear)
                    .cornerRadius(20, corners: .allCorners)
                    .overlay {
                        if !isFavorite {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white, lineWidth: 3)
                        }
                    }
                }
            }
        }
        .multilineTextAlignment(.center)
        .onAppear {
            withAnimation {
                if isFavorite {
                    title = "This company is on the list of favorites"
                } else {
                    title = "Add this company to your favorites for quicker retrieval "
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.green
        
        VStack(spacing: 30) {
            OfficeDefaultView(
                budget: 2500,
                isFavorite: false
            ) {_ in }
            
            OfficeDefaultView(
                budget: 2500,
                isFavorite: true
            ) {_ in }
        }
        .padding()
    }
}
