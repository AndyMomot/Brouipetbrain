//
//  ChallengesTabView.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 22.11.2024.
//

import SwiftUI

struct ChallengesTabView: View {
    @Binding var currentPageIndex: Int
    var items: [ChallengeModel]
    
    var body: some View {
        TabView(selection: $currentPageIndex) {
            ForEach(items) { item in
                ChallangeCell(item: item)
                    .tag(item.id)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}

#Preview {
    ChallengesTabView(
        currentPageIndex: .constant(0),
        items: [])
}
