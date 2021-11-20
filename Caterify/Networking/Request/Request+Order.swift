//
//  Request+Order.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine

// Order Request service information
struct OrderRequest: Service {
    var baseUrl: String = Constants.Endpoint.baseUrl
    typealias Network = OrderDescription
}

// Order Request function
extension OrderRequest: OrderInterface {
    func getAllOrders() -> AnyPublisher<CABaseResponse<OrderGetResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<OrderGetResponse>>()
        return call.doConnect(request: Network.getAllOrders, baseUrl: baseUrl)
    }
    
    func postOrder(id: Int, start: String, end: String) -> AnyPublisher<CABaseResponse<Order>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<Order>>()
        return call.doConnect(request: Network.postOrder(id: id, start: start, end: end), baseUrl: baseUrl)
    }
}
