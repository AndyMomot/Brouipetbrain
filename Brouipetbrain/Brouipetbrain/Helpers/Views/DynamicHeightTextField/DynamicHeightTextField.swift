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
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.silver)
                
                TextEditor(text: $text)
                    .foregroundStyle(Colors.darkBlue.swiftUIColor)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .padding()
                
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(Colors.darkBlue.swiftUIColor.opacity(0.6))
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
        Color.green
        
        DynamicHeightTextField(
            title: "Uwaga do projektu",
            text: .constant(""))
        .frame(maxHeight: 117)
        .padding()
    }
}
