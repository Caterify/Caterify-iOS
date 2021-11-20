//
//  Schedule.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation

class Schedule: Codable {
    var id: Int?
    var date: String? // Kalo gabisa ganti string ae
    var price: Int?
    
    var menu: Menu?
    
    func dateToString() -> String {
        return date!.toDate()!.toString()
    }
}

struct RangedScheduleBaseResponse: Codable {
    var total: Int
    var totalPrice: Int
    var schedules: [Schedule]
    
    private enum CodingKeys: String, CodingKey {
        case total,
             totalPrice = "total_price",
             schedules
    }
}


