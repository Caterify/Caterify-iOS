//
//  SampleGetResponse.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation

// You can get the sample at https://kasir.farrelanshary.me/docs

struct SampleGetResponse: Codable {
    var provinces: [Province]
}

struct Province: Codable, Identifiable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
}
