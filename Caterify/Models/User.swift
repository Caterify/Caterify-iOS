//
//  User.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation

class User: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var phone: String?
    var role: Int?
    var password: String?
    var address: String?
    var radius: Int?
    var latitude: Double?
    var longitude: Double?
    
    var orders: [Order]?
}

struct AuthPostResponse: Codable {
    var token: String?
    var user: User?
}
