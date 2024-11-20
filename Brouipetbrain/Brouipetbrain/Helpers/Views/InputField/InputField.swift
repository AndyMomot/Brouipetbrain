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
        VStack(alignment: .leading, spacing: 11) {
            Text(title)
                .foregroundStyle(Colors.darkBlue.swiftUIColor)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
            
            TextField(text: $text) {
                if let placeholder {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                        .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                        .opacity(0.8)
                }
            }
            .foregroundStyle(Colors.darkBlue.swiftUIColor)
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            .padding(.horizontal, 12)
            .padding(.vertical, 28)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Colors.darkBlue.swiftUIColor, lineWidth: 1)
            }
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
