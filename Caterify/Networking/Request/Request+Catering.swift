//
//  Request+Catering.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine

// Catering Request service information
struct CateringRequest: Service {
    var baseUrl: String = Constants.Endpoint.baseUrl
    typealias Network = CateringDescription
}

// Sample Request function
extension CateringRequest: CateringInterface {
    func getFeaturedCaterings(lat: Double, long: Double) -> AnyPublisher<CABaseResponse<CateringGetResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<CateringGetResponse>>()
        return call.doConnect(request: Network.getFeaturedCaterings(lat: lat, long: long), baseUrl: baseUrl)
    }
}
