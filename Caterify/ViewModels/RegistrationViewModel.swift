//
//  RegistrationViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI
import CoreLocation
import Combine

enum UserRole{
    case customer, owner, undefined
}

final class RegistrationViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var role: UserRole = .customer
    @Published var isErrorEmail: Bool = false
    @Published var emailErrorDescription: String = "Email is invalid"
    
    @Published var isErrorPhone: Bool = false
    @Published var phoneErrorDescription: String = "Phone is invalid"
    
    @Published var isPasswordError: Bool = false
    @Published var passwordErrorDescription: String = "Password is invalid"
    
    @AppStorage("address") var savedAddress: String = "Address Not Set"
    @AppStorage("locality") var savedLocality: String = ""
    @AppStorage("latitude") var latitude: CLLocationDegrees = 0.0
    @AppStorage("longitude") var longitude: CLLocationDegrees = 0.0
    @AppStorage("addressNotes") var savedAddressNotes: String = ""
    @AppStorage("token") var token: String = ""
    
    private let authRequest = AuthRequest()
    private var cancellable = Set<AnyCancellable>()
    
    func register() {
        authRequest.register(name: name, email: email, phone: phone, password: password, passwordConfirmation: confirmPassword, role: 1, address: savedAddress, radius: 15000, latitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    guard let code = err.code else { return }
                    if code == 422 {
                        guard let errors = err.errors else { return }
                        if let emailError = errors.email {
                            self?.isErrorEmail = true
                            self?.emailErrorDescription = emailError.first!
                        }
                        if let passError = errors.password {
                            self?.isPasswordError = true
                            self?.passwordErrorDescription = passError.first!
                        }
                        if let phoneError = errors.phone {
                            self?.isErrorPhone = true
                            self?.phoneErrorDescription = phoneError.first!
                        }
                        
                        print("Debug register: \(errors)")
                    }
                    print("Debug Register: \(err.code)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                guard let token = data.token else { return }
                self?.token = token
                print("Debug register: \(self?.token)")
            }
            .store(in: &cancellable)
    }
}
