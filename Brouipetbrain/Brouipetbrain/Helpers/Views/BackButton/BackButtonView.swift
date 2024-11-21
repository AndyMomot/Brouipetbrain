//
//  BackButtonView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        HStack {
            Button {
                dismiss.callAsFunction()
            } label: {
                Image(systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.deepBlue)
                    .padding(.vertical, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 12)
                    .background(.silver)
                    .clipShape(Circle())
                    .frame(width: 38)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ZStack {
        Color.green
        BackButtonView()
    }
}
