//
//  Interface+Catering.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine

// Catering Interface Functions
protocol CateringInterface: Service {
    func getFeaturedCaterings(lat: Double, long: Double) -> AnyPublisher<CABaseResponse<CateringGetResponse>, CABaseErrorModel>
}

// Sample Request Enum
enum CateringDescription {
    case getFeaturedCaterings(lat: Double, long: Double)
}

extension CateringDescription: NetworkDescription {
    var path: String {
        switch self {
        case .getFeaturedCaterings:
            return "/api/public/caterings/featured"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .getFeaturedCaterings(let lat, let long):
            return [
                "api_key": Constants.ServerEnvironment.apiKey,
                "latitude": String(lat),
                "longitude": String(long)
            ]
        }
    }
}
