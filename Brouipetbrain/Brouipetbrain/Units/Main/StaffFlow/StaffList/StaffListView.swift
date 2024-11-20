//
//  StaffListView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 20.11.2024.
//

import SwiftUI

struct StaffListView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Asset.tabBg.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("Create an employee")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
                        .multilineTextAlignment(.center)
                        .shadow(radius: 10)
                    
                    Button {
                        viewModel.showAddPerson.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.black)
                                .frame(height: 25)
                            Spacer()
                        }
                        .padding(7)
                        .background(.white)
                        .cornerRadius(20, corners: .allCorners)
                    }
                    
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 35) {
                            HStack {
                            Text("Employees")
                                .foregroundStyle(.white)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                Spacer()
                            }
                            
                            VStack(spacing: 25) {
                                ForEach(viewModel.staff) { person in
                                    PersonCell(
                                        person: person,
                                        canDelete: true) { idToDelete in
                                            viewModel.deletePerson(id: idToDelete)
                                        }
                                }
                            }
                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                    }
                    .scrollIndicators(.never)
                }
                .padding(.horizontal, 10)
            }
            .onAppear {
                viewModel.getStaff()
            }
            .navigationDestination(isPresented: $viewModel.showAddPerson) {
                AddPersonView()
            }
        }
    }
}

#Preview {
    StaffListView()
}
