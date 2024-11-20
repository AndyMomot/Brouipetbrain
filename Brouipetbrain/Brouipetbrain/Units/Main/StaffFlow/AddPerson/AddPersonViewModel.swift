//
//  AddPersonViewModel.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 20.11.2024.
//

import Foundation
import UIKit.UIImage

extension AddPersonView {
    final class ViewModel: ObservableObject {
        @Published var showImagePicker = false
        @Published var image = Asset.placeholder.image
        @Published var name = ""
        @Published var position = ""
        @Published var salary = ""
        
        func create(completion: @escaping () -> Void) {
            DispatchQueue.global().async { [weak self] in
                guard let self,
                      self.image != Asset.placeholder.image,
                      !self.name.isEmpty,
                      !self.position.isEmpty,
                      Int(self.salary) ?? .zero > .zero,
                      let imageData = self.image.jpegData(compressionQuality: 1)
                else { return }
                
                let person = PersonModel(
                    name: self.name,
                    position: self.position,
                    salary: Int(self.salary) ?? .zero
                )
                
                DefaultsService.shared.staff.append(person)
                ImageStorageManager().saveImage(data: imageData, for: person.id)
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
