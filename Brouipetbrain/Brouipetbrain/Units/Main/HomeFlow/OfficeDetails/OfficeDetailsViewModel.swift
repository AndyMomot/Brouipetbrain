//
//  OfficeDetailsViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import Foundation

extension OfficeDetailsView {
    final class ViewModel: ObservableObject {
        @Published var office: OfficeModel?
        @Published var contentState: ContentState = .default
        
        @Published var freeEmployees: [PersonModel] = []
        
        func getOffice(id: String) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                let office = DefaultsService.shared.offices.first(where: {$0.id == id})
                DispatchQueue.main.async { [self] in
                    self.office = office
                }
            }
        }
        
        func getFreeStaff(officeId: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                var freeEmployees = DefaultsService.shared.staff
                
                if let addedEmployees = DefaultsService.shared.offices.first(where: {$0.id == officeId})?.employees {
                    addedEmployees.forEach { employee in
                        freeEmployees.removeAll(where: {$0.id == employee.id})
                    }
                }
                
                DispatchQueue.main.async { [self] in
                    self.freeEmployees = freeEmployees
                }
            }
        }
        
        func setState(_ state: ContentState) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if self.contentState == state {
                    self.contentState = .default
                } else {
                    self.contentState = state
                }
            }
        }
        
        func updateFavorites(id: String, isFavorite: Bool) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                guard let index = DefaultsService.shared.offices.firstIndex(where: {$0.id == id})
                else { return }
                DefaultsService.shared.offices[index].isFavorite = isFavorite
                let office = DefaultsService.shared.offices[index]
                DispatchQueue.main.async { [self] in
                    self.office = office
                }
            }
        }
        
        func addEmployee(employeeId: String, to officeId: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                
                let sharedDefaults = DefaultsService.shared
                
                if let employeeIndex = sharedDefaults.staff.firstIndex(where: { $0.id == employeeId }),
                   let officeIndex = sharedDefaults.offices.firstIndex(where: { $0.id == officeId }),
                   !sharedDefaults.offices[officeIndex].employees.contains(where: { $0.id == employeeId }),
                   sharedDefaults.offices[officeIndex].employees.count <= 10 {

                    let employee = sharedDefaults.staff[employeeIndex]
                    sharedDefaults.offices[officeIndex].employees.append(employee)
                    
                    self.getOffice(id: officeId)
                    self.getFreeStaff(officeId: officeId)
                }
            }
        }
        
        func removeEmployee(employeeId: String, from officeId: String) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                
                let sharedDefaults = DefaultsService.shared
                
                if let officeIndex = sharedDefaults.offices.firstIndex(where: { $0.id == officeId }),
                   let employeeIndex = sharedDefaults.staff.firstIndex(where: { $0.id == employeeId })
                    {
                    sharedDefaults.offices[officeIndex].employees.remove(at: employeeIndex)
                    
                    self.getOffice(id: officeId)
                    self.getFreeStaff(officeId: officeId)
                }
            }
        }
        
        func removeOffice(id: String, completion: @escaping () -> Void) {
            DispatchQueue.global().async {
                let sharedDefaults = DefaultsService.shared
                if let index = sharedDefaults.offices.firstIndex(where: {$0.id == id}) {
                    sharedDefaults.offices[index].isDeleted = true
                }
                DispatchQueue.main.async { completion() }
            }
        }
    }
    
    enum ContentState {
        case `default`
        case addEmployee
        case removeEmployee
    }
}
