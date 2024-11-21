//
//  CreateBicycleField.swift
//  Millvelorotour
//
//  Created by Andrii Momot on 26.10.2024.
//

import SwiftUI

struct InputField: View {
    var title: String
    var placeholder: String?
    var style: Style?
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(
                    style?.titleColor ?? Colors.deepBlue.swiftUIColor
                )
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
            
            TextField(text: $text) {
                if let placeholder {
                    Text(placeholder)
                        .foregroundStyle(
                            style?.textColor.opacity(0.6) ?? .gray.opacity(0.8)
                        )
                        .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                }
            }
            .foregroundStyle(
                style?.textColor ?? Colors.deepBlue.swiftUIColor
            )
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
            .padding(.horizontal, 9)
            .padding(.vertical, 16)
            .background(
                style?.bgColor ?? .gray.opacity(0.4)
            )
            .cornerRadius(10, corners: .allCorners)
        }
    }
}

extension InputField {
    struct Style {
        var titleColor, textColor, bgColor: Color
    }
}

#Preview {
    VStack(spacing: 20) {
        InputField(title: "Email",
                   placeholder: "Twój email",
                   text: .constant(""))
        
        InputField(title: "Email",
                   placeholder: "Twój email",
                   text: .constant("Some@email.com"))
        
    }
    .padding()
}
