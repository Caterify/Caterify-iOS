//
//  CustomerRegistrationView.swift
//  Caterify
//
//  Created by Joanda Febrian on 19/11/21.
//

import SwiftUI

struct CustomerRegistrationView: View {
    
    @StateObject var viewModel = CustomerRegistrationViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CustomerRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerRegistrationView()
    }
}
