//
//  OfficesView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct OfficesView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Asset.tabBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                BackButtonView()
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 24) {
                        ZStack {
                            Capsule()
                                .fill(.silver)
                                .padding(.top)
                            
                            HStack {
                                Asset.myOffices.swiftUIImage
                                    .resizable()
                                    .scaledToFit()
                                
                                Spacer()
                                
                                Text("My offices")
                                    .foregroundStyle(.green)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
                                    .padding(.trailing)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        if viewModel.offices.isEmpty {
                            HomeButton(
                                imageName: Asset.addOffice.name,
                                title: "Create an office") {
                                    viewModel.showCreateOffice.toggle()
                                }
                                .padding(50)
                                .navigationDestination(isPresented: $viewModel.showCreateOffice) {
                                    AddOfficeView()
                                }
                        } else {
                            VStack(spacing: 15) {
                                ForEach(viewModel.offices) { office in
                                    Button {
                                        viewModel.officeIdToShow = office.id
                                        viewModel.showOfficeDetails.toggle()
                                    } label: {
                                        OfficeCell(
                                            item: office,
                                            canDelete: true) { id in
                                                viewModel.setAsDeletedOffice(id: id)
                                            }
                                    }
                                }
                            }
                            .padding(.leading, 16)
                        }
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                }
                .scrollIndicators(.never)
            }
        }
        .onAppear {
            withAnimation {
                viewModel.getOffices()
            }
        }
        .navigationDestination(isPresented: $viewModel.showOfficeDetails) {
            if let id = viewModel.officeIdToShow {
                OfficeDetailsView(officeId: id)
            }
        }
    }
}

#Preview {
    OfficesView()
}
