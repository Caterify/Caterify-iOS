//
//  Request+One.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine

// Sample Request service information
struct SampleRequest: Service {
    var baseUrl: String = "https://kasir.farrelanshary.me" // Nanti mah ambil dari constants
    typealias Network = SampleDescription
}

// Sample Request function
extension SampleRequest: SampleInterface {
    func getAllProvinces() -> AnyPublisher<CABaseResponse<SampleGetResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<SampleGetResponse>>()
        return call.doConnect(request: Network.getAllProvinces, baseUrl: baseUrl)
    }
    
    func getAllRegencies(provinceId: Int) {
        
    }
}
