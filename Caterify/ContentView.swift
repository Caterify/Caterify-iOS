//
//  ContentView.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("side") var side: String = "login"
    @State var userRole: UserRole = .undefined
    
    var body: some View {
        switch side {
        case "owner":
            OwnerView()
        case "customer":
            CustomerView()
        case "login":
            LoginView(userRole: $userRole)
        case "register":
            if(userRole == .undefined){
                SelectRoleView(userRole: $userRole)
            }else{
                RegistrationView(userRole: $userRole)
            }
        default:
            LoginView(userRole: $userRole)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
