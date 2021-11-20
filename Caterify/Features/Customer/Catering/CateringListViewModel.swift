//
//  CateringListViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation

final class CateringListViewModel: ObservableObject {
    
    @Published var caterings: [Catering] = []
    
    init(_ caterings: [Catering]) {
        self.caterings = caterings
    }
    
}
