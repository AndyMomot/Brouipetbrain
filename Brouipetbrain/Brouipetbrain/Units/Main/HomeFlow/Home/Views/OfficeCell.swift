//
//  OfficeCell.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct OfficeCell: View {
    var item: OfficeModel
    var canDelete: Bool
    var onDelete: ((_ id: String) -> Void)?
    
    @State private var image = Asset.placeholder.swiftUIImage
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        HStack(spacing: 14) {
            HStack(spacing: 10) {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: bounds.width * 0.26,
                           height: bounds.width * 0.26)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(item.name)
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                        
                        Text(item.description)
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                    }
                    .padding(.vertical, 15)
                    .padding(.trailing, 6)
                    .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
            }
            .background(.darkBlue)
            .cornerRadius(10, corners: .allCorners)
            
            if canDelete {
                if canDelete {
                    Button {
                        onDelete?(item.id)
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.black)
                            .frame(width: 14)
                            .padding(10)
                            .background(.silver)
                            .cornerRadius(15, corners: [.topLeft, .bottomLeft])
                    }
                }
            }
        }
        .frame(height: bounds.width * 0.26)
        .onAppear {
            withAnimation {
                getImage()
            }
        }
    }
}

private extension OfficeCell {
    func getImage() {
        ImageStorageManager().fetchImage(with: item.id) { data in
            guard let data,
                    let uiImage = UIImage(data: data)
            else { return }
            image = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    ZStack {
        Color.greenCustom
        
        VStack {
            OfficeCell(item: .init(
                name: "EcoPulse Innovations",
                budget: 10_000,
                numberOfEmployees: 8,
                description: "A green tech company dedicated to developing cutting-edge solutions for sustainable energy, waste management, and eco-friendly products. Their goal is to drive environmental change through innovation and smart technologies."),
                       canDelete: false)
            
            OfficeCell(item: .init(
                name: "EcoPulse Innovations",
                budget: 10_000,
                numberOfEmployees: 8,
                description: "A green tech company dedicated to developing cutting-edge solutions for sustainable energy, waste management, and eco-friendly products. Their goal is to drive environmental change through innovation and smart technologies. Their goal is to drive environmental change through innovation and smart technologies."),
                       canDelete: true)
        }
        .padding(.horizontal, 16)
    }
}
