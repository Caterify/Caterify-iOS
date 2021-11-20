//
//  OwnerRegistrationViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 19/11/21.
//

import Foundation

final class OwnerRegistrationViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var address: Address = Address(notes: "", latitude: .defaultLat, longitude: .defaultLng)
    
}
