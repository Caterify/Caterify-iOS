//
//  LoginView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @AppStorage("side") var side: String = "login"
    @Binding var userRole: UserRole
    
    var body: some View {
        NavigationView{
            VStack(spacing: 24){
                CustomForm(placeholder: "Email", title: "Email", type: .normal, field: $viewModel.email,isError: $viewModel.isErrorEmail,
                           errorDescription: $viewModel.emailErrorDescription)
                
                CustomForm(placeholder: "Password", title: "Password", type: .secure, field: $viewModel.password,isError: $viewModel.isPassError,
                           errorDescription: $viewModel.passwordErrorDescription)
            
                Button {
                    print("Signed in")
                    viewModel.login()
                } label: {
                    Text("Login")
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }.padding(.top,16)
                .tint(Color.main)
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                HStack{
                    Text("Don't have an account?")
                        .font(.caption)
                    Button {
                        side = "register"
                    } label: {
                        Text("Sign up now")
                            .font(.caption)
                            .foregroundColor(Color.main)
                    }
                }
                Divider()
                HStack{
                    Text("ONLY FOR TESTING")
                        .font(.caption)
                    Button {
                        viewModel.email = "andriani.ira@example.net"
                        viewModel.password = "admin123"
                    } label: {
                        Text("Dummy Customer Account")
                            .font(.caption)
                            .foregroundColor(Color.main)
                    }
                }
                HStack{
                    Text("ONLY FOR TESTING")
                        .font(.caption)
                    Button {
                        viewModel.email = "tsaragih@example.net"
                        viewModel.password = "admin123"
                    } label: {
                        Text("Dummy Catering Account")
                            .font(.caption)
                            .foregroundColor(Color.main)
                    }
                }
                Spacer()
                Button {
                    side = "customer"
                } label: {
                    Text("Skip Login")
                        .foregroundColor(.primary)
                }
                .navigationTitle("Login")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onTapGesture {
                endTextEditing()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.horizontal,16)
        }
        .onAppear {
            userRole = .undefined
        }
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
