//
//  StatisticsViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 22.11.2024.
//

import Foundation

extension StatisticsView {
    final class ViewModel: ObservableObject {
        @Published var offices: [OfficeModel] = []
        
        func getOffices() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let offices = DefaultsService.shared.offices.filter { !$0.isDeleted }
                DispatchQueue.main.async { [self] in
                    self.offices = offices
                }
            }
        }
    }
}
