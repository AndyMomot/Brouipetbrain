//
//  StaffListViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 20.11.2024.
//

import Foundation

extension StaffListView {
    final class ViewModel: ObservableObject {
        @Published var showAddPerson = false
        @Published var staff: [PersonModel] = []
        
        func getStaff() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let staff = DefaultsService.shared.staff
                DispatchQueue.main.async { [self] in
                    self.staff = staff
                }
            }
        }
        
        func deletePerson(id: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                DefaultsService.shared.staff.removeAll(where: {$0.id == id})
                self.getStaff()
            }
        }
    }
}
