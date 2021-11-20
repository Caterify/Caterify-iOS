//
//  OwnerView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct OwnerView: View {
    
    @StateObject var viewModel = OwnerViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OwnerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerView()
    }
}
