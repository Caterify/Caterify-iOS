//
//  CreateMenuView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CreateMenuView: View {
    
    @StateObject var viewModel = CreateMenuViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CreateMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMenuView()
    }
}
