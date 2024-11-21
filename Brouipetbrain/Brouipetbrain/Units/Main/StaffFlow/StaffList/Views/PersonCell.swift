//
//  PersonCell.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 20.11.2024.
//

import SwiftUI

struct PersonCell: View {
    var person: PersonModel
    var canDelete: Bool
    var onDelete: ((_ id: String) -> Void)?
    
    @State private var image = Asset.placeholder.swiftUIImage
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        HStack(spacing: 20) {
            image
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: bounds.width * 0.186,
                       height: bounds.width * 0.186)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(person.name)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                    Text(person.position)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 10))
                    Spacer()
                }
                
                Spacer()
                
                Text("\(person.salary)".toNumberFormat())
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 17)
                    .padding(.vertical, 3)
                    .background(Colors.deepBlue.swiftUIColor)
                    .cornerRadius(11, corners: .allCorners)
                
                Spacer()
                
                if canDelete {
                    Button {
                        onDelete?(person.id)
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 14)
                            .padding(10)
                            .background(Colors.greenCustom.swiftUIColor)
                            .cornerRadius(15, corners: [.topLeft, .bottomLeft])
                        
                    }
                }
            }
            .foregroundStyle(Colors.deepBlue.swiftUIColor)
            .padding(.vertical, 7)
            .padding(.leading, 7)
            .background(.white)
            .cornerRadius(10, corners: .allCorners)
        }
        .onAppear {
            getImage()
        }
    }
}

private extension PersonCell {
    func getImage() {
        ImageStorageManager().fetchImage(with: person.id) { data in
            guard let data,
                    let uiImage = UIImage(data: data)
            else { return }
            image = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    ZStack {
        Asset.tabBg.swiftUIImage
            .resizable()
        
        VStack {
            PersonCell(person: .init(
                name: "Alex",
                position: "iOS Developer",
                salary: 2000
            ), canDelete: true) {_ in}
            .frame(height: 80)
            
            PersonCell(person: .init(
                name: "Alex",
                position: "iOS Developer",
                salary: 2000
            ), canDelete: false)
            .frame(height: 80)
        }
        .padding()
    }
}
