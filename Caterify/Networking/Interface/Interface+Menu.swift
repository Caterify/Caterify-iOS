//
//  Interface+Menu.swift
//  Caterify
//
//  Created by Farrel Anshary on 21/11/21.
//

import Foundation
import SwiftUI
import Combine

// Menu Interface Functions
protocol MenuInterface: Service {
    func createMenu(name: String, description: String) -> AnyPublisher<CABaseResponse<MenuPostResonse>, CABaseErrorModel>
}

// Menu Request Enum
enum MenuDescription {
    case createMenu(name: String, description: String)
}

extension MenuDescription: NetworkDescription {
    var path: String {
        switch self {
        case .createMenu:
            return "/api/private/menus"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createMenu:
            return .POST
        }
    }
    
    var queryParams: [String : String]? {
        switch self {
        case .createMenu(let name, let description):
            return [
                "api_key": Constants.ServerEnvironment.apiKey,
                "name": name,
                "description": description
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
