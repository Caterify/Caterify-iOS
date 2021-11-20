//
//  LoginViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation
import Combine
import SwiftUI

final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isErrorEmail: Bool = false
    @Published var isPassError: Bool = false
    @Published var emailErrorDescription: String = ""
    @Published var passwordErrorDescription: String = ""
    
    @AppStorage("token") var token: String = ""
    @AppStorage("side") var side: String = "login"
    
    private let authRequest = AuthRequest()
    private var cancellable = Set<AnyCancellable>()
    
    
    func login() {
        authRequest.login(email: email, password: password)
            .receive(on: DispatchQueue.main, options: nil)
            .sink { [weak self] result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    guard let code = err.code else { return }
                    if code == 404 {
                        self?.isErrorEmail = true
                        self?.emailErrorDescription = "Email not found"
                    } else if code == 403 {
                        self?.isPassError = true
                        self?.passwordErrorDescription = "Invalid credentials"
                    }
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                guard let token = data.token else { return }
                print("Debug login: \(token)")
                self?.token = token
                self?.side = data.user!.role! == 1 ? "owner" : "customer"
            }
            .store(in: &cancellable)

    }
    
}
