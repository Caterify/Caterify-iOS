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
    @State  var currentTab: OwnerTab = .menu
    @State var isAddingMenu: Bool = false
    @State var date: Date = Date()
    
    init() {
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.systemBackground
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                ScheduleMenuView(date: $date)
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
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingMenu.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.main)
                    }

                }
            })
            .navigationTitle("Caterify")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isAddingMenu) {
                CreateMenuView(isPresented: $isAddingMenu, date: $date)
            }
        }
    }
    
}

struct OwnerView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerView()
    }
}
