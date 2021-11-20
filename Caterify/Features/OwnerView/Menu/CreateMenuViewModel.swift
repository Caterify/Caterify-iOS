//
//  CreateMenuViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation

final class CreateMenuViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var image: String = ""
    @Published var description: String = ""
    
}
