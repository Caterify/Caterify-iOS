//
//  Interface+One.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine

// Sample Interface Functions
protocol SampleInterface: Service {
    func getAllProvinces() -> AnyPublisher<CABaseResponse<SampleGetResponse>, CABaseErrorModel>
    func getAllRegencies(provinceId: Int) // Samain aja
}

// Sample Request Enum
enum SampleDescription {
    case getAllProvinces
    case getAllRegencies(provinceId: Int)
}

extension SampleDescription: NetworkDescription {
    var path: String {
        switch self {
        case .getAllProvinces:
            return "/api/general/provinces"
        case .getAllRegencies(provinceId: let id):
            return "/api/general/regencies/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllProvinces:
            return .GET
        case .getAllRegencies(provinceId: _):
            return .GET
        }
    }
    
    var queryParams: [String : String]? {
        return ["api_key": "bukanUser"]
    }
}
