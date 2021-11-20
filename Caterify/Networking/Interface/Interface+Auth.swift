//
//  Interface+Auth.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import Foundation
import Combine

// Schedule Interface Functions
protocol AuthInterface: Service {
    func login(email: String, password: String) -> AnyPublisher<CABaseResponse<AuthPostResponse>, CABaseErrorModel>
    func register(
        name: String,
        email: String,
        phone: String,
        password: String,
        passwordConfirmation: String,
        role: Int,
        address: String,
        radius: Int,
        latitude: Double,
        longitude: Double
    ) -> AnyPublisher<CABaseResponse<AuthPostResponse>, CABaseErrorModel>
}

// Schedule Request Enum
enum AuthDescription {
    case login(email: String, password: String)
    case register(
        name: String,
        email: String,
        phone: String,
        password: String,
        passwordConfirmation: String,
        role: Int,
        address: String,
        radius: Int,
        latitude: Double,
        longitude: Double
    )
}

extension AuthDescription: NetworkDescription {
    var path: String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .register:
            return "/api/auth/register"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .POST
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .login(let email, let password):
            return [
                "api_key": Constants.ServerEnvironment.apiKey,
                "email": email,
                "password": password
            ]
        case .register(let name, let email, let phone, let password, let passwordConfirmation, let role, let address, let radius, let latitude, let longitude):
            return [
                "name": name,
                "email": email,
                "phone": phone,
                "password": password,
                "password_confirmation": passwordConfirmation,
                "role": String(role),
                "address": address,
                "radius": String(radius),
                "latitude": String(latitude),
                "longitude": String(longitude),
                "api_key": Constants.ServerEnvironment.apiKey
            ]
        }
    }
}
