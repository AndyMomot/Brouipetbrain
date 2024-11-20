//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    @State private var items: [TabBar.Item] = [
        .init(imageName: Asset.officeTab.name),
        .init(imageName: Asset.staffTab.name),
        .init(imageName: Asset.analyticsTab.name),
        .init(imageName: Asset.challengesTab.name)
    ]
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]
                    let isSelected = index == selectedItem
                    
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                        .background(
                            isSelected ? Colors.greenCustom.swiftUIColor : .clear
                        )
                        .clipShape(Circle())
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.2)) {
                                selectedItem = index
                            }
                        }
                    
                    if index < items.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background(Colors.deepBlue.swiftUIColor)
            .cornerRadius(30, corners: .allCorners)
            .frame(maxHeight: 59)
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Colors.darkBlue.swiftUIColor)
        .cornerRadius(30, corners: [.topLeft, .topRight])
    }
}

#Preview {
    ZStack {
        
        VStack {
            Spacer()
            TabBarCustomView(selectedItem: .constant(0))
                .frame(height: 126)
        }
        .ignoresSafeArea()
    }
}
