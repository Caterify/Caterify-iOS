//
//  Order.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation

class Order: Codable {
    var id: Int?
    var rating: Int?
    var review: String?
    var status: Int?
    var schedule: Schedule?
    var user: User?
}

struct OrderGetResponse: Codable {
    var orders: [Order]
}
