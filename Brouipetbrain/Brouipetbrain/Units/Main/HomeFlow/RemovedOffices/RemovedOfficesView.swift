//
//  RemovedOfficesView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct RemovedOfficesView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.tabBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                BackButtonView()
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 28) {
                        ZStack {
                            Color.darkBlue
                                .cornerRadius(56, corners: .allCorners)
                            VStack(spacing: 20) {
                                RoundedRectangle(cornerRadius: 56)
                                    .fill(.silver)
                                    .overlay {
                                        HStack {
                                            Asset.trash.swiftUIImage
                                                .resizable()
                                                .scaledToFit()
                                            
                                            Text("Removed offices")
                                                .foregroundStyle(.greenCustom)
                                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
                                        }
                                        .padding()
                                    }
                                    .frame(height: bounds.width * 0.3)
                                
                                Text("In this section you can view or delete your offices")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                    .padding(.bottom)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 15) {
                            ForEach(viewModel.offices) { office in
                                OfficeCell(
                                    item: office,
                                    canDelete: true) { id in
                                        viewModel.deleteOffice(id: id) {
                                            viewModel.getOffices()
                                        }
                                    }
                            }
                        }
                        .padding(.leading, 16)
                    }
                    .padding(.bottom, bounds.height * 0.1)
                }
                .scrollIndicators(.never)
            }
        }
        .onAppear {
            viewModel.getOffices()
        }
    }
}

#Preview {
    RemovedOfficesView()
}
