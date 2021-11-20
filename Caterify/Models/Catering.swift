//
//  Catering.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation

class Catering: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var phone: String?
    var password: String?
    var imageURL: String?
    var address: String?
    var radius: Int?
    var latitude: Double?
    var longitude: Double?
    var distance: Double?
    var averagePrice: Double?
    var averageRating: Double?
    var menus: [Menu]?
    
    init(id: Int? = nil, name: String? = nil, email: String? = nil, phone: String? = nil, password: String? = nil, imageURL: String? = nil, address: String? = nil, radius: Int? = nil, latitude: Double? = nil, longitude: Double? = nil, distance: Double? = nil, averagePrice: Double? = nil, menus: [Menu]? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.password = password
        self.imageURL = imageURL
        self.address = address
        self.radius = radius
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
        self.averagePrice = averagePrice
        self.averageRating = 4
        self.menus = menus
    }
    
    private enum CodingKeys: String, CodingKey {
        case id,
             name,
             email,
             phone,
             password,
             imageURL = "image",
             address,
             radius,
             latitude,
             longitude,
             distance,
             averagePrice = "average_price",
             averageRating = "average_rating",
             menus
    }
}

struct CateringGetResponse: Codable {
    var caterings: [Catering]
}
