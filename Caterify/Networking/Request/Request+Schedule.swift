//
//  Request+Schedule.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine

// Schedule Request service information
struct ScheduleRequest: Service {
    var baseUrl: String = Constants.Endpoint.baseUrl
    typealias Network = ScheduleDescription
}

// Schedule Request function
extension ScheduleRequest: ScheduleInterface {
    func getScheduleInRange(id: Int, start: String, end: String) -> AnyPublisher<CABaseResponse<RangedScheduleBaseResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<RangedScheduleBaseResponse>>()
        return call.doConnect(request: Network.getScheduleInRange(id: id, start: start, end: end), baseUrl: baseUrl)
    }
}
