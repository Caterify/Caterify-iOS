//
//  Interface+Order.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine
import SwiftUI

// Schedule Interface Functions
protocol OrderInterface: Service {
    func postOrder(id: Int, start: String, end: String) -> AnyPublisher<CABaseResponse<Order>, CABaseErrorModel>
    func getAllOrders() -> AnyPublisher<CABaseResponse<OrderGetResponse>, CABaseErrorModel>
}

// Schedule Request Enum
enum OrderDescription {
    case postOrder(id: Int, start: String, end: String)
    case getAllOrders
}

extension OrderDescription: NetworkDescription {
    var path: String {
        switch self {
        default:
            return "/api/private/orders"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postOrder:
            return .POST
        case .getAllOrders:
            return .GET
        }
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .postOrder(let id, let start, let end):
            return [
                "api_key": Constants.ServerEnvironment.apiKey,
                "catering_id": String(id),
                "start": start,
                "end": end
            ]
        case .getAllOrders:
            return [
                "api_key": Constants.ServerEnvironment.apiKey
            ]
        }
    }
    
    var headers: [String : String]? {
        @AppStorage("token") var token: String = ""
        switch self {
        default:
            return [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        }
    }
}
