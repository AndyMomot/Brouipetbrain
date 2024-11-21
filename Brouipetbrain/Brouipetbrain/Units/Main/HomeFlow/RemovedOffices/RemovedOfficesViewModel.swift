//
//  RemovedOfficesViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import Foundation

extension RemovedOfficesView {
    final class ViewModel: ObservableObject {
        @Published var offices: [OfficeModel] = []
        
        func getOffices() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let offices = DefaultsService.shared.offices.filter { $0.isDeleted }
                DispatchQueue.main.async { [self] in
                    self.offices = offices
                }
            }
        }
        
        func deleteOffice(id: String, completion: @escaping () -> Void) {
            DispatchQueue.global().async {
                DefaultsService.shared.offices.removeAll(where: {$0.id == id })
                DispatchQueue.main.async { completion() }
            }
        }
        
    }
}
