//
//  ScheduleMenuViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation

final class ScheduleMenuViewModel: ObservableObject {
    
    @Published var menu: Menu?
    @Published var date: Date = Date()
    @Published var price: Int = 0
    
}
