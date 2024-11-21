//
//  HomeViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var showCreateOffice = false
        @Published var showOffices = false
        @Published var showRemovedOffices = false
        
        @Published var favoriteOffices: [OfficeModel] = []
        
        func getOffices() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let offices = DefaultsService.shared.offices.filter { $0.isFavorite }
                
                DispatchQueue.main.async { [self] in
                    self.favoriteOffices = offices
                }
            }
        }
        
        func setAsDeletedOffice(id: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      let index = DefaultsService.shared.offices.firstIndex(where: {$0.id == id})
                else { return }
                DefaultsService.shared.offices[index].isDeleted = true
                getOffices()
            }
        }
    }
}
