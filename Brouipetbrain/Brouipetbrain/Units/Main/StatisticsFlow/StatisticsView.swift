//
//  StatisticsView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 22.11.2024.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Asset.tabBg.swiftUIImage
                .resizable()
                .opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 30) {
                    HStack {
                        Spacer()
                        Text("Statistics")
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 30))
                            .minimumScaleFactor(0.8)
                            .shadow(radius: 10)
                        Spacer()
                    }
                    
                    Text("One employee contributes about 10% of total revenue, with key team members collectively driving up to 25% of the company's income.")
                        .foregroundStyle(.darkBlue)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 18))
                }
                
                ScrollView {
                    VStack(spacing: 25) {
                        ForEach(viewModel.offices) { office in
                            OfficeStatisticsCell(item: office)
                                .shadow(radius: 10, y: 5)
                        }
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.1)
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            viewModel.getOffices()
        }
    }
}

#Preview {
    StatisticsView()
}
