//
//  OfficeAddEmployeeView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import SwiftUI

struct OfficeAddEmployeeView: View {
    var employees: [PersonModel]
    var canDelete: Bool
    var onSelect: (String) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(employees) { employee in
                Button {
                    onSelect(employee.id)
                } label: {
                    PersonCell(person: employee,
                               canDelete: canDelete,
                               backgroundColor: .silver) { id in
                        onSelect(id)
                    }
                }
            }
            
            HStack {
                Spacer()
                Text("You can add no more than 10 people to a project")
                    .foregroundStyle(canDelete ? .white : .deepBlue)
                    .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
        .padding(15)
        .background(
            canDelete ? .deepBlue : .white
        )
        .cornerRadius(10, corners: .allCorners)
    }
}

#Preview {
    ScrollView {
        ZStack {
            Color.green
            
            VStack {
                OfficeAddEmployeeView(
                    employees: [
                        .init(
                            name: "Name 1",
                            position: "Position 1",
                            salary: 100
                        ),
                        .init(
                            name: "Name 2",
                            position: "Position 2",
                            salary: 100
                        ),
                    ],
                    canDelete: false) {_ in}
                
                OfficeAddEmployeeView(
                    employees: [
                        .init(
                            name: "Name 1",
                            position: "Position 1",
                            salary: 100
                        ),
                        .init(
                            name: "Name 2",
                            position: "Position 2",
                            salary: 100
                        ),
                    ],
                    canDelete: true) {_ in}
            }
            .padding()
        }
    }
}
