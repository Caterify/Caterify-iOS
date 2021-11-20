//
//  LoginViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 19/11/21.
//

import Foundation

final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
}
