//
//  AddOfficeView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct AddOfficeView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss
    
    private var tfStyle = InputField.Style(
        titleColor: .white,
        textColor: .darkBlue,
        bgColor: .silver
    )
    private let placeholder = "Write the information"
    
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
                
                Text("Create an office")
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
                    .multilineTextAlignment(.center)
                
                ScrollView {
                    VStack(spacing: 14) {
                        Button {
                            viewModel.showImagePicker.toggle()
                        } label: {
                            Image(uiImage: viewModel.image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: bounds.width * 0.33)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 5)
                        }

                        InputField(
                            title: "Company name",
                            placeholder: placeholder,
                            style: tfStyle,
                            text: $viewModel.name
                        )
                        
                        InputField(
                            title: "Company budget",
                            placeholder: placeholder,
                            style: tfStyle,
                            text: $viewModel.budget
                        )
                        .keyboardType(.numberPad)
                        
                        InputField(
                            title: "Approximate team composition (1-10)",
                            placeholder: placeholder,
                            style: tfStyle,
                            text: $viewModel.numberOfEmployee
                        )
                        .keyboardType(.numberPad)
                        
                        DynamicHeightTextField(
                            title: "Company Description",
                            placeholder: placeholder,
                            text: $viewModel.description
                        )
                        .frame(minHeight: 240)
                    }
                    .padding(.bottom, bounds.height * 0.1)
                }
                .scrollIndicators(.never)
                
                HStack(spacing: 20) {
                    Text("Set up your company so you can start recruiting. ")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                    
                    Spacer()
                    
                    NextButton(title: "Create") {
                        viewModel.save {
                            dismiss.callAsFunction()
                        }
                    }
                    .frame(height: 55)
                }
            }
            .padding(.horizontal, 16)
        }
        .hideKeyboardWhenTappedAround()
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
        .onChange(of: viewModel.numberOfEmployee) { newValue in
            if newValue == "" { return }
            let intValue = Int(newValue) ?? .zero
            if intValue < 1 { viewModel.numberOfEmployee = "1" }
            if intValue > 10 { viewModel.numberOfEmployee = "10" }
        }
    }
}

#Preview {
    AddOfficeView()
}
