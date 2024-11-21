//
//  AddOfficeViewMode.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 21.11.2024.
//

import Foundation
import UIKit.UIImage

extension AddOfficeView {
    final class ViewModel: ObservableObject {
        @Published var image = Asset.placeholder.image
        @Published var showImagePicker = false
        
        @Published var name = ""
        @Published var budget = ""
        @Published var numberOfEmployee = ""
        @Published var description = ""
        
        func save(completion: @escaping () -> Void) {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      !self.name.isEmpty,
                      Int(self.budget) ?? .zero > .zero,
                      Int(self.numberOfEmployee) ?? .zero > .zero,
                      Int(self.numberOfEmployee) ?? .zero <= 10,
                      !self.description.isEmpty,
                      self.image != Asset.placeholder.image,
                      let imageData = image.jpegData(compressionQuality: 1)
                else { return }
                
                let newOffice = OfficeModel(
                    name: self.name,
                    budget: Int(self.budget) ?? .zero,
                    numberOfEmployees: Int(self.numberOfEmployee) ?? .zero,
                    description: self.description
                )
                
                DefaultsService.shared.offices.append(newOffice)
                ImageStorageManager().saveImage(data: imageData, for: newOffice.id)
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
