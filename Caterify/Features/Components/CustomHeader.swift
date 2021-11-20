//
//  CustomHeader.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CustomHeader: View {
    
    @Environment(\.dismiss) var dismiss
    let title: String
    
    var body: some View {
        ZStack(alignment:.center) {
            Text(title)
                .font(.headline)
            HStack(alignment: .center, spacing: 8) {
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .padding(.trailing, 16)
                        .contentShape(Rectangle())
                }
                Spacer()
            }
        }
        .padding(16)
        .font(.headline)
        .foregroundColor(.white)
        .background(Color.main)
    }
}

struct CustomerHomeHeader: View {
    
    @AppStorage("address") var address: String = ""
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @State var isSelectingAddress: Bool = false
    
    @FocusState var isSearchFocused: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if isSearching {
                TextField("Search", text: $searchText)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(4)
                    .focused($isSearchFocused)
                    .task {
                        isSearchFocused = true
                    }
                Spacer()
                Button("Cancel") {
                    isSearching.toggle()
                    searchText = ""
                }
            } else {
                Button {
                    isSelectingAddress.toggle()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                    Text(address.isEmpty ? "Address Not Set" : address)
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 12, height: 6)
                        .padding(.top, 4)
                }
                Spacer()
                Button {
                    isSearching.toggle()
                    isSearchFocused = true
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .padding(16)
        .font(.headline)
        .foregroundColor(.white)
        .background(Color.main)
        .sheet(isPresented: $isSelectingAddress) {
            AddressPickerView()
        }
    }
}

struct CustomHeader_Previews: PreviewProvider {
    static var previews: some View {
//        CustomHeader(title: "Title")
        NavigationView {
            VStack {
                CustomerHomeHeader(searchText: .constant(""), isSearching: .constant(false))
                    .navigationBarHidden(true)
                Spacer()
            }
        }
    }
}
