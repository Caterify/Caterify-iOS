//
//  AddressPickerView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct AddressPickerView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AddressPickerViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    GMSUIViewRep(location: $viewModel.location, authorizationFailed: $viewModel.authorizationFailed)
                    MapPin()
                }
                AddressSheet(viewModel) {
                    if let coordinate = viewModel.location?.coordinate,
                       let address = viewModel.address {
                        viewModel.savedAddress = address
                        viewModel.savedLocality = viewModel.area!
                        viewModel.longitude = coordinate.longitude
                        viewModel.latitude = coordinate.latitude
                        viewModel.savedAddressNotes = viewModel.addressNotes
                    }
                    self.dismiss()
                }
            }
            .alert("Location Services Required", isPresented: $viewModel.authorizationFailed, actions: {
                Button("Go Back", role: .cancel) {
                    self.dismiss()
                }
                Button("Settings") {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    self.dismiss()
                }
            }, message: {
                Text("You can enable Location Services in Privacy Settings")
            })
            .navigationTitle("Select Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        self.dismiss()
                    }
                }
            }
        }
    }
}

struct MapPin: View {
    var body: some View {
        Image(systemName: "mappin")
            .resizable()
            .scaledToFit()
            .frame(height: 40)
            .padding(.bottom, 40)
            .foregroundColor(.main)
    }
}

struct AddressSheet: View {
    
    @ObservedObject private var viewModel: AddressPickerViewModel
    @FocusState private var focusState: Bool
    
    let action: () -> Void
    
    let placeholder = "abcdefghijklmnopqrstuvwxyz"
    
    init(_ viewModel: AddressPickerViewModel, action: @escaping () -> Void ) {
        self.viewModel = viewModel
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading) {
                Text(viewModel.address ?? placeholder)
                    .redacted(reason: viewModel.address == nil ? .placeholder : [])
                Text(viewModel.area ?? placeholder)
                    .font(.caption)
                    .redacted(reason: viewModel.address == nil ? .placeholder : [])
            }
            TextField("Catatan", text: $viewModel.addressNotes)
                .focused($focusState, equals: true)
                .redacted(reason: viewModel.address == nil ? .placeholder : [])
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            focusState.toggle()
                        }
                    }
                }
            Button {
                action()
            } label: {
                HStack {
                    Spacer()
                    Text("Select Location")
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            .buttonStyle(.borderedProminent)
            .tint(.main)
            .buttonBorderShape(.roundedRectangle)
            
        }
        .padding(32)
        .frame(idealHeight: 100)
        .background(.regularMaterial)
    }
}

struct AddressPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AddressPickerView()
    }
}
