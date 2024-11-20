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
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(Colors.deepBlue.swiftUIColor)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
            
            TextField(text: $text) {
                if let placeholder {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                        .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                        .opacity(0.8)
                }
            }
            .foregroundStyle(Colors.deepBlue.swiftUIColor)
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
            .padding(.horizontal, 9)
            .padding(.vertical, 16)
            .background(.gray.opacity(0.4))
            .cornerRadius(10, corners: .allCorners)
        }
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
