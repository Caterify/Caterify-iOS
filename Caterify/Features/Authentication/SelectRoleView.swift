//
//  SelectRoleView.swift
//  Caterify
//
//  Created by Meichel Rendio on 20/11/21.
//

import SwiftUI

struct SelectRoleView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @AppStorage("side") var side: String = "register"
    @Binding var userRole: UserRole
    var body: some View {
        NavigationView{
            VStack(spacing: 16){
                Button {
                    userRole = .owner
                } label: {
                    Text("Catering Owner")
                        .padding(46)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.lightGrey)
                        )
                        .foregroundColor(Color.primary)
                }
                
                HStack{
                    Rectangle()
                        .frame(maxHeight: 2)
                    Text("or")
                    Rectangle()
                        .frame(maxHeight: 2)
                }
                
                Button {
                    userRole = .customer
                } label: {
                    Text("Customer")
                        .padding(46)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.lightGrey)
                        )
                        .foregroundColor(Color.primary)
                        
                }
                Spacer()
                HStack{
                    Text("Already have an account?")
                        .font(.caption)
                    Button {
                        side = "login"
                    } label: {
                        Text("Log in now")
                            .font(.caption)
                            .foregroundColor(Color.main)
                    }
                }

            }
            .navigationTitle("Register")
            .padding(.horizontal, 16)
            .padding(.top,16)
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

//struct SelectRoleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectRoleView()
//    }
//}
