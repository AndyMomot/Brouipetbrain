//
//  NextButton.swift
//  Libarorent
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var bgColor: Color = Colors.darkBlue.swiftUIColor
    var textColor: Color = .white
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                bgColor
                
                Text(title)
                    .foregroundStyle(textColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 8)
                
            }
            .cornerRadius(8, corners: .allCorners)
            .shadow(color: Colors.darkBlue.swiftUIColor.opacity(0.1), radius: 8)
        }
    }
}


#Preview {
    ZStack {
        VStack(spacing: 20) {
            NextButton(title: "Komputeryrerererer") {}
                .frame(width: 200, height: 44)
            
            NextButton(title: "Komputeryrerererer",
                       bgColor: .yellow,
                       textColor: .black
            ) {}
                .frame(width: 200, height: 44)
        }
    }
}
