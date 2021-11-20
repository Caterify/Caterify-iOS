//
//  ScheduleMenuView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct ScheduleMenuView: View {
    
    @StateObject var viewModel = ScheduleMenuViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ScheduleMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleMenuView()
    }
}
