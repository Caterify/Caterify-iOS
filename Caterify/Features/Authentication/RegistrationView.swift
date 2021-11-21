//
//  RegistrationView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct RegistrationView: View {
    
    enum RegisterType {
        case customer, catering
    }
    @StateObject var viewModel = RegistrationViewModel()
    @State var isPresented: Bool = false
    @AppStorage("side") var side: String = "register"
    @Binding var userRole: UserRole
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    VStack(spacing: 16){
                        CustomForm(placeholder: "e.g. John Doe", title: userRole == .customer ? "Name" : "Catering Name", type: .normal, field: $viewModel.name,isError: .constant(false),
                                   errorDescription: .constant(""))
                        CustomForm(placeholder: "e.g. johndoe@email.com", title: "Email", type: .normal, field: $viewModel.email,isError: $viewModel.isErrorEmail,
                                   errorDescription: $viewModel.emailErrorDescription)
                        CustomForm(placeholder: "*********", title: "Password", type: .secure, field: $viewModel.password,isError: $viewModel.isPasswordError,
                                   errorDescription: $viewModel.passwordErrorDescription)
                        CustomForm(placeholder: "*********", title: "Confirm Password", type: .secure, field: $viewModel.confirmPassword,isError: .constant(false),
                                   errorDescription: .constant(""))
                        CustomForm(placeholder: "e.g. 081266666666", title: "Phone Number", type: .numeric, field: $viewModel.phone,isError: $viewModel.isErrorPhone,
                                   errorDescription: $viewModel.phoneErrorDescription)
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Location")
                                .font(.caption)
                            Button {
                                isPresented.toggle()
                            } label: {
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(viewModel.savedAddress)
                                        if !viewModel.savedLocality.isEmpty {
                                            Text(viewModel.savedLocality)
                                                .font(.caption)
                                        }
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(.ultraThinMaterial)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.ultraLightGrey)
                                )
                                .contentShape(Rectangle())
                                
                            }
                        }
                    }
                }.padding(.horizontal,16)
                Group{
                    Button {
                        print("Signed in")
                        viewModel.register(selectedRole: userRole == .owner ? 1 : 2)
                    } label: {
                        Text("Sign Up")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
                    .tint(Color.main)
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty || viewModel.confirmPassword.isEmpty || viewModel.name.isEmpty || viewModel.phone.isEmpty || viewModel.savedLocality.isEmpty )
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
                
            }
            .padding(.top,16)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        userRole = .undefined
                    } label: {
                        Image(systemName: "chevron.backward")
                    }

                    
                }
            })
            .sheet(isPresented: $isPresented) {
                AddressPickerView()
            }
        }
        
    }
}



//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            RegistrationView()
//        }
//
//    }
//}
