//
//  CreateMenuView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CreateMenuView: View {
    
    @StateObject private var viewModel = CreateMenuViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        Button {
                            viewModel.isSelectingSourceType.toggle()
                        } label: {
                            ImagePickerButton(image: $viewModel.image)
                        }
                        .buttonStyle(.plain)
                        .actionSheet(isPresented: $viewModel.isSelectingSourceType){
                            ActionSheet(title: Text("Select Photo"),
                                        message: nil, buttons: [
                                            .default(Text("Choose from library")){
                                                viewModel.sourceType = .photoLibrary
                                                viewModel.isShowingImagePicker = true
                                            },
                                            .default(Text("Take a picture")){
                                                viewModel.sourceType = .camera
                                                viewModel.isShowingImagePicker = true
                                            },
                                            .cancel()
                                        ])
                        }
                        .sheet(isPresented: $viewModel.isShowingImagePicker, content: {
                            ImagePicker(isPresented: $viewModel.isShowingImagePicker, selectedImage: $viewModel.image, sourceType: viewModel.sourceType)
                        })
                        CustomForm(placeholder: "e.g. Monday Package", title: "Menu Name", type: .normal, field: $viewModel.name, isError: .constant(false), errorDescription: .constant(""))
                        CustomForm(placeholder: "e.g. Seafood Fried Rice and Chicken", title: "Menu Description", type: .normal, field: $viewModel.description, isError: .constant(false), errorDescription: .constant(""))
                        
                        let priceProxy = Binding<String>(
                            get: { viewModel.price.toRupiah() },
                            set: {
                                let result = Int($0.filter("0123456789".contains)) ?? 0
                                viewModel.price = result
                            }
                        )
                        
                        CustomForm(placeholder: "e.g. Rp15.000", title: "Price", type: .price, field: priceProxy, isError: .constant(false), errorDescription: .constant(""))
                    }
                    .padding(24)
                }
                Spacer()
                Button {
                    print("Submit Menu")
                } label: {
                    Text("Submit Menu")
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 24)
                .tint(Color.main)
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.name.isEmpty ||
                          viewModel.description.isEmpty ||
                          viewModel.price != 0)
            }
            .navigationTitle("Add Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            isPresented.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.main)
                            .padding(.bottom, 8)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CreateMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMenuView(isPresented: .constant(true))
    }
}
