//
//  OfficeDetailsView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct OfficeDetailsView: View {
    var officeId: String
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var image = Asset.placeholder.swiftUIImage
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.tabBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    BackButtonView()
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    Button {
                        viewModel.removeOffice(id: officeId) {
                            dismiss.callAsFunction()
                        }
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.black)
                            .frame(width: 14)
                            .padding(10)
                            .background(.silver)
                            .cornerRadius(15, corners: [.topLeft, .bottomLeft])
                            .frame(height: 38)
                        
                    }
                }
                
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: bounds.width * 0.26,
                                       height: bounds.width * 0.26)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Spacer()
                            
                            Text(viewModel.office?.name ?? "")
                                .foregroundStyle(.darkBlue)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 25))
                        }
                        .padding(.vertical, 15)
                        .padding(.horizontal, 45)
                        .background(.silver)
                        .cornerRadius(68, corners: [.topLeft, .topRight])
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Company Description")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                            
                            HStack {
                                Text(viewModel.office?.description ?? "")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(.darkBlue)
                            .cornerRadius(10, corners: .allCorners)
                        }
                        
                        HStack {
                            Button {
                                withAnimation {
                                    viewModel.setState(.addEmployee)
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.white)
                                    
                                    Asset.addEmployee.swiftUIImage
                                        .resizable()
                                        .scaledToFit()
                                        .padding(14)
                                }
                                .frame(height: 55)
                            }

                            Spacer(minLength: 20)
                            
                            NextButton(title: "Team composition") {
                                withAnimation {
                                    viewModel.setState(.removeEmployee)
                                }
                            }
                            .frame(height: 55)
                        }
                        
                        switch viewModel.contentState {
                        case .default:
                            OfficeDefaultView(
                                budget: viewModel.office?.budget ?? .zero,
                                isFavorite: viewModel.office?.isFavorite ?? false) { isFavorite in
                                    viewModel.updateFavorites(
                                        id: officeId,
                                        isFavorite: isFavorite
                                    )
                                }
                        case .addEmployee:
                            if viewModel.freeEmployees.isEmpty {
                                Text("You need to create some employees")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                                    .multilineTextAlignment(.center)
                            } else {
                                OfficeAddEmployeeView(
                                    employees: viewModel.freeEmployees,
                                    canDelete: false) { id in
                                        viewModel.addEmployee(
                                            employeeId: id,
                                            to: officeId
                                        )
                                    }
                            }
                        case .removeEmployee:
                            if viewModel.office?.employees.isEmpty == true {
                                Text("There are no employees yet")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 20))
                                    .multilineTextAlignment(.center)
                            } else {
                                OfficeAddEmployeeView(
                                    employees: viewModel.office?.employees ?? [],
                                    canDelete: true) { id in
                                        viewModel.removeEmployee(employeeId: id, from: officeId)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, bounds.height * 0.1)
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            getImage()
            viewModel.getOffice(id: officeId)
            viewModel.getFreeStaff(officeId: officeId)
        }
    }
}

private extension OfficeDetailsView {
    func getImage() {
        ImageStorageManager().fetchImage(with: officeId) { data in
            guard let data,
                    let uiImage = UIImage(data: data)
            else { return }
            image = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    OfficeDetailsView(officeId: "")
}
