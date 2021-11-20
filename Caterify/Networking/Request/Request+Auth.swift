//
//  Request+Auth.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine

// Auth Request service information
struct AuthRequest: Service {
    var baseUrl: String = Constants.Endpoint.baseUrl
    typealias Network = AuthDescription
}

// Auth Request function
extension AuthRequest: AuthInterface {
    func register(name: String, email: String, phone: String, password: String, passwordConfirmation: String, role: Int, address: String, radius: Int, latitude: Double, longitude: Double) -> AnyPublisher<CABaseResponse<AuthPostResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<AuthPostResponse>>()
        return call.doConnect(request: Network.register(name: name, email: email, phone: phone, password: password, passwordConfirmation: passwordConfirmation, role: role, address: address, radius: radius, latitude: latitude, longitude: longitude), baseUrl: baseUrl)
    }
    
    func login(email: String, password: String) -> AnyPublisher<CABaseResponse<AuthPostResponse>, CABaseErrorModel> {
        let call = Connector<Network, CABaseResponse<AuthPostResponse>>()
        return call.doConnect(request: Network.login(email: email, password: password), baseUrl: baseUrl)
    }
}
