//
//  CreateMenuViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

final class CreateMenuViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var image: UIImage?
    @Published var description: String = ""
    @Published var price: PriceInt = 0
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    @Published var isShowingImagePicker: Bool = false
    @Published var isSelectingSourceType: Bool = false
    
}
