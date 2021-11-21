//
//  CreateMenuView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CreateMenuView: View {
    
    @ObservedObject private var viewModel: CreateMenuViewModel
    @Binding var isPresented: Bool
    @Binding var date: Date
    @State var isShowingDatePicker: Bool = false
    
    init(date: Binding<Date>, isPresented: Binding<Bool>) {
        self.viewModel = CreateMenuViewModel(date: date)
        self._isPresented = isPresented
        self._date = date
    }
    
    var body: some View {
        NavigationView {
            VStack {
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
                    
                    VStack(alignment: .leading, spacing: 8){
                        Text("Menu Date")
                            .font(.caption)
                        VStack {
                            if !isShowingDatePicker {
                                HStack {
                                    Text(date.toString())
                                        .padding(14)
                                    Spacer()
                                }
                            } else {
                                DatePicker("Menu Date", selection: $date, displayedComponents: .date)
                                    .labelsHidden()
                                    .id(date)
                                    .datePickerStyle(WheelDatePickerStyle())
                            }
                        }
                        .onTapGesture {
                            isShowingDatePicker.toggle()
                        }
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
                .padding(24)
                Spacer()
                Button {
                    print("Submit Menu")
                    viewModel.createMenu()
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
            .onTapGesture {
                isShowingDatePicker.toggle()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onTapGesture(perform: {
                endTextEditing()
            })
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
        CreateMenuView(date: .constant(Date()), isPresented: .constant(false))
    }
}
