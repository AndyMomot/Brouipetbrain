//
//  OfficesViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import Foundation

extension OfficesView {
    final class ViewModel: ObservableObject {
        @Published var showCreateOffice = false
        @Published var offices: [OfficeModel] = []
        @Published var showOfficeDetails = false
        var officeIdToShow: String?
        
        func getOffices() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let offices = DefaultsService.shared.offices.filter { !$0.isDeleted }
                DispatchQueue.main.async { [self] in
                    self.offices = offices
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
