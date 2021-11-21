//
//  OwnerView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct OwnerView: View {
    enum OwnerTab{
        case menu, order
    }
    @StateObject var viewModel = OwnerViewModel()
    @State private var currentTab: OwnerTab = .menu
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                ScheduleMenuView()  
                    .tabItem {
                        Label("Menu", systemImage: "house.fill")
                    }
                    .tag(OwnerTab.menu)
                OrderView()
                    .tabItem {
                        Label("Order", systemImage: "list.bullet.rectangle")
                    }
                    .tag(OwnerTab.order)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.main)
                    }

                }
            })
        }
    }
    
}

struct OwnerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerView()
    }
}
