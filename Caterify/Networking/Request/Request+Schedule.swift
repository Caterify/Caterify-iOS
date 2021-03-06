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
    func createSchedule(date: String, price: Int, menu_id: Int) -> AnyPublisher<CABaseResponse<ScheduleBaseResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<ScheduleBaseResponse>>()
        return call.doConnect(request: Network.createSchedule(date: date, price: price, menu_id: menu_id), baseUrl: baseUrl)
    }
    
    func changeStatus(scheduleId: Int, status: Int) -> AnyPublisher<CABaseResponse<ScheduleBaseResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<ScheduleBaseResponse>>()
        return call.doConnect(request: Network.changeStatus(scheduleId: scheduleId, status: status), baseUrl: baseUrl)
    }
    
    func getAllPrivateSchedules() -> AnyPublisher<CABaseResponse<SchedulesBaseResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<SchedulesBaseResponse>>()
        return call.doConnect(request: Network.getAllPrivateSchedules, baseUrl: baseUrl)
    }
    
    func getScheduleInRange(id: Int, start: String, end: String) -> AnyPublisher<CABaseResponse<RangedScheduleBaseResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<RangedScheduleBaseResponse>>()
        return call.doConnect(request: Network.getScheduleInRange(id: id, start: start, end: end), baseUrl: baseUrl)
    }
    
    func getScheduleOfCatering(date: String) -> AnyPublisher<CABaseResponse<ScheduleBaseResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<ScheduleBaseResponse>>()
        return call.doConnect(request: Network.getScheduleOfCatering(date: date), baseUrl: baseUrl)
    }
}
