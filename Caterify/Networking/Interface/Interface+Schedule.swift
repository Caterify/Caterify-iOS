//
//  Interface+Schedule.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine
import SwiftUI

// Schedule Interface Functions
protocol ScheduleInterface: Service {
    func getScheduleInRange(id: Int, start: String, end: String) -> AnyPublisher<CABaseResponse<RangedScheduleBaseResponse>, CABaseErrorModel>
    func getScheduleOfCatering(date: String) -> AnyPublisher<CABaseResponse<ScheduleBaseResponse>, CABaseErrorModel>
    func getAllPrivateSchedules() -> AnyPublisher<CABaseResponse<SchedulesBaseResponse>, CABaseErrorModel>
    func changeStatus(scheduleId: Int, status: Int) -> AnyPublisher<CABaseResponse<ScheduleBaseResponse>, CABaseErrorModel>
}

// Schedule Request Enum
enum ScheduleDescription {
    case getScheduleInRange(id: Int, start: String, end: String)
    case getScheduleOfCatering(date: String)
    case getAllPrivateSchedules
    case changeStatus(scheduleId: Int, status: Int)
}

extension ScheduleDescription: NetworkDescription {
    var path: String {
        switch self {
        case .getScheduleInRange(let id, _, _):
            return "/api/public/schedules/catering/\(id)/range"
        case .getScheduleOfCatering:
            return "/api/private/schedules/date"
        case .getAllPrivateSchedules:
            return "/api/private/schedules"
        case .changeStatus(let scheduleId, _):
            return "/api/private/schedules/\(scheduleId)/change-status"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .changeStatus:
            return .PATCH
        default:
            return .GET
        }
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .getScheduleInRange(_, let start, let end):
            return [
                "api_key": Constants.ServerEnvironment.apiKey,
                "start": start,
                "end": end
            ]
        case .getScheduleOfCatering(let date):
            return [
                "api_key": Constants.ServerEnvironment.apiKey,
                "date": date
            ]
        case .getAllPrivateSchedules:
            return [
                "api_key": Constants.ServerEnvironment.apiKey
            ]
        case .changeStatus(_, let status):
            return [
                "api_key": Constants.ServerEnvironment.apiKey,
                "status": String(status)
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
