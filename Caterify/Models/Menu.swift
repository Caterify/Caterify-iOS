//
//  Menu.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation

class Menu: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var description: String?
    var user: User?
    
    var schedules: [Schedule]?
}
