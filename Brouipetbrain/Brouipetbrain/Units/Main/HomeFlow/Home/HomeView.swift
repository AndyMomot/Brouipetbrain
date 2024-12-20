//
//  HomeView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.tabBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        HStack(spacing: 20) {
                            HomeButton(
                                imageName: Asset.addOffice.name,
                                title: "Create an office") {
                                    viewModel.showCreateOffice.toggle()
                                }
                                .navigationDestination(isPresented: $viewModel.showCreateOffice) {
                                    AddOfficeView()
                                }
                            
                            VStack(spacing: 20) {
                                HomeButton(
                                    imageName: Asset.office.name,
                                    title: "My offices") {
                                        viewModel.showOffices.toggle()
                                    }
                                    .navigationDestination(isPresented: $viewModel.showOffices) {
                                        OfficesView()
                                    }
                                
                                HomeButton(
                                    imageName: Asset.officeDelete.name,
                                    title: "Removed offices") {
                                        viewModel.showRemovedOffices.toggle()
                                    }
                                    .navigationDestination(isPresented: $viewModel.showRemovedOffices) {
                                        RemovedOfficesView()
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 17) {
                            Rectangle()
                                .fill(.silver)
                                .frame(height: 5)
                            
                            HStack {
                                Text("Selected offices")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        VStack(spacing: 15) {
                            ForEach(viewModel.favoriteOffices) { office in
                                Button {
                                    viewModel.officeIdToShow = office.id
                                    viewModel.showOfficeDetails.toggle()
                                } label: {
                                    OfficeCell(
                                        item: office,
                                        canDelete: true) { id in
                                            withAnimation {
                                                viewModel.setAsDeletedOffice(id: id)
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.leading, 16)
                    }
                    .padding(.vertical, bounds.height * 0.1)
                }
                .scrollIndicators(.never)
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
}

#Preview {
    HomeView()
}
