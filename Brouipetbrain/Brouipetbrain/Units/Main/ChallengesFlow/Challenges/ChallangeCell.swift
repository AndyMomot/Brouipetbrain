//
//  ChallangeCell.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 22.11.2024.
//

import SwiftUI

struct ChallangeCell: View {
    var item: ChallengeModel
    
    @State private var isCompleted = false
    @State private var canUpdate = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.silver)
            
            VStack(alignment: .leading, spacing: 50) {
                Text(item.title)
                    .foregroundStyle(.deepBlue)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                
                HStack(alignment: .top, spacing: 6) {
                    Text("•")
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                    Group {
                        Text("Description: ")
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                        +
                        Text(item.description)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                    }
                    .lineSpacing(12)
                }
                .foregroundColor(.deepBlue)
                
                HStack(alignment: .top, spacing: 6) {
                    Text("•")
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                    Group {
                        Text("Goal: ")
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                        +
                        Text(item.goal)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 15))
                    }
                    .lineSpacing(12)
                }
                .foregroundColor(.deepBlue)
                
                Spacer()
                
                HStack {
                    Spacer(minLength: 100)
                    
                    Button {
                        if canUpdate {
                            withAnimation {
                                isCompleted.toggle()
                            }
                        }
                        
                        if isCompleted {
                            setCompletionStatus(id: item.id)
                        } else {
                            removeCompletionStatus(id: item.id)
                        }
                        
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(.deepBlue)
                            
                            Capsule()
                                .fill(.white)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                            
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.green)
                                .padding(.vertical, 14)
                                .opacity(isCompleted ? 1 : 0)
                        }
                    }
                    .frame(height: 55)
                    
                    Spacer(minLength: 100)
                }
            }
            .padding(30)
        }
        .onAppear {
            getCompletionStatus(id: item.id)
        }
    }
}

private extension ChallangeCell {
    func getCompletionStatus(id: Int) {
        canUpdate = false
        
        DispatchSerialQueue.global().async {
            let challengeIDs = DefaultsService.shared.challenges
            let isCompleted = challengeIDs.contains(where: {$0 == id})
            
            DispatchSerialQueue.main.async {
                self.isCompleted = isCompleted
                self.canUpdate = true
            }
        }
    }
    
    func setCompletionStatus(id: Int) {
        canUpdate = false
        
        DispatchSerialQueue.global().async {
            DefaultsService.shared.challenges.append(id)
            DispatchSerialQueue.main.async {
                self.canUpdate = true
            }
        }
    }
    
    func removeCompletionStatus(id: Int) {
        canUpdate = false
        
        DispatchSerialQueue.global().async {
            DefaultsService.shared.challenges.removeAll(where: {$0 == id})
            DispatchSerialQueue.main.async {
                self.canUpdate = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color.greenCustom
            .ignoresSafeArea()
        
        ChallangeCell(
            item: .init(
                id: 0,
                title: "Building a Multi-Container Application Using Docker and Docker Compose",
                description: "Create an application with multiple microservices (e.g., frontend, backend, and database) using Docker and Docker Compose. Each service should run in its own container.",
                goal: "Understand the principles of containerization, working with Docker and Docker Compose."
            ))
        .padding()
    }
}
