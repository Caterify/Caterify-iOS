//
//  CustomerView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CustomerView: View {
    
    enum CustomerTab {
        case home, subscriptions
    }
    
    @StateObject var viewModel = CustomerViewModel()
    @State private var currentTab: CustomerTab = .home
    
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
                CustomerHomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(CustomerTab.home)
                CustomerSubscriptionView()
                    .tabItem {
                        Label("My Subscriptions", systemImage: "list.bullet.rectangle")
                    }
                    .tag(CustomerTab.subscriptions)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CustomerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerView()
    }
}
