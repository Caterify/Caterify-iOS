//
//  Constants.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation

struct Constants {
    struct Endpoint {
        static let baseUrl = "https://caterify.xyz"
        static let placeholderImage = "https://caterify.xyz/images/placeholder"
    }
    struct ServerEnvironment {
        static let apiKey = "supersecretkey"
    }
    static let OrderStatus = ["Received","In Progress","Completed"]
}

