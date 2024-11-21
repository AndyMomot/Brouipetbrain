//
//  AddPersonView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 20.11.2024.
//

import SwiftUI

struct AddPersonView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.darkBlue.swiftUIColor
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 65) {
                    VStack(spacing: 40) {
                        Text("Create an employee")
                            .foregroundStyle(Colors.greenCustom.swiftUIColor)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
                            .multilineTextAlignment(.center)
                            .padding(.top, 100)
                            .padding(.horizontal, 10)
                        
                        ZStack {
                            Rectangle()
                                .fill(Colors.darkBlue.swiftUIColor)
                                .frame(height: 22)
                            
                            Button {
                                viewModel.showImagePicker.toggle()
                            } label: {
                                Image(uiImage: viewModel.image)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: bounds.width * 0.3,
                                           height: bounds.width * 0.3)
                            }
                        }
                        
                        VStack(spacing: 9) {
                            InputField(
                                title: "Employee name",
                                placeholder: "Write the information",
                                text: $viewModel.name
                            )
                            InputField(
                                title: "Employee position",
                                placeholder: "Write the information",
                                text: $viewModel.position
                            )
                            InputField(
                                title: "Employee's salary",
                                placeholder: "Write the information",
                                text: $viewModel.salary
                            )
                            .keyboardType(.numberPad)
                        }
                        .padding(.horizontal, 10)
                        
                        NextButton(title: "Create") {
                            viewModel.create {
                                dismiss.callAsFunction()
                            }
                        }
                        .frame(height: 55)
                        .padding(.horizontal, 130)
                        .padding(.bottom, 10)
                    }
                    .background(.white)
                    .cornerRadius(50, corners: .allCorners)
                    
                    Text("You can add no more than 10 people to a project")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                .padding(.bottom, bounds.height * 0.1)
            }
            .scrollIndicators(.never)
            .ignoresSafeArea(edges: .top)
        }
        .hideKeyboardWhenTappedAround()
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
    }
}

#Preview {
    AddPersonView()
}
