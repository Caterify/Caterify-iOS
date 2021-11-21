//
//  Request+Menu.swift
//  Caterify
//
//  Created by Farrel Anshary on 21/11/21.
//

import Foundation
import Combine

// Menu Request service information
struct MenuRequest: Service {
    var baseUrl: String = Constants.Endpoint.baseUrl
    typealias Network = MenuDescription
}

// Menu Request function
extension MenuRequest: MenuInterface {
    func createMenu(name: String, description: String) -> AnyPublisher<CABaseResponse<MenuPostResonse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<MenuPostResonse>>()
        return call.doConnect(request: Network.createMenu(name: name, description: description), baseUrl: baseUrl)
    }
}
