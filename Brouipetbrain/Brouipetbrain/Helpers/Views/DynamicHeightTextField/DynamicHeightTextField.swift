//
//  DynamicHeightTextField.swift
//  Chainestery
//
//  Created by Andrii Momot on 21.08.2024.
//

import SwiftUI

struct DynamicHeightTextField: View {
    var title: String
    var placeholder: String = "Napisz tekst"
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(Colors.darkBlue.swiftUIColor)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                
                TextEditor(text: $text)
                    .foregroundStyle(Colors.darkBlue.swiftUIColor)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Colors.darkBlue.swiftUIColor, lineWidth: 1)
                            .padding(2)
                    }
                
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(Color.gray)
                        .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                        .opacity(0.8)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 26)
                        .allowsHitTesting(false)
                }
            }
            .cornerRadius(20, corners: .allCorners)
        }
    }
}

#Preview {
    ZStack {
       
        DynamicHeightTextField(
            title: "Uwaga do projektu",
            text: .constant(""))
        .frame(maxHeight: 117)
        .padding()
    }
}
