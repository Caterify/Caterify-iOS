//
//  CustomerHomeView.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI

struct CustomerHomeView: View {
    
    @StateObject var viewModel = CustomerViewModel()
    @State var searchQuery = ""
    @State var isSearching = false
    
    var body: some View {
        ZStack {
            Color.main
                .edgesIgnoringSafeArea(.top)
            VStack(spacing: 0) {
                CustomerHomeHeader(searchText: $searchQuery, isSearching: $isSearching)
                ScrollView {
                    if isSearching {
                        CateringListView(caterings: searchQuery.isEmpty ? viewModel.featured : viewModel.featured.filter { $0.name!.contains(searchQuery) }, title: "Search")
                    } else {
                        VStack {
                            HomeComponent(title: "Featured", buttonTitle: "View All") {
                                CateringListView(caterings: viewModel.featured, title: "Featured")
                            } content: {
                                if viewModel.doneLoadingFeature {
                                    CateringList(type: .horizontal, caterings: Array(viewModel.featured.prefix(4)))
                                } else {
                                    CateringListPreview(type: .horizontal)
                                        .redacted(reason: .placeholder)
                                }
                            }.onAppear {
                                viewModel.getFeatured()
                            }
                            
                            HomeComponent(title: "Affordable", buttonTitle: "View All") {
                                CateringListView(caterings: viewModel.affordable, title: "Affordable")
                            } content: {
                                if viewModel.doneLoadingFeature {
                                    CateringList(type: .horizontal, caterings: Array(viewModel.affordable.prefix(4)))
                                } else {
                                    CateringListPreview(type: .horizontal)
                                        .redacted(reason: .placeholder)
                                }
                            }
                            
                            HomeComponent(title: "Nearby Caterings", buttonTitle: "View All") {
                                CateringListView(caterings: viewModel.nearby, title: "Nearby")
                            } content: {
                                if viewModel.doneLoadingFeature {
                                    CateringList(type: .vertical, caterings: Array(viewModel.nearby.prefix(4)))
                                } else {
                                    CateringListPreview(type: .vertical)
                                        .redacted(reason: .placeholder)
                                }
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
                .background(Color.ultraLightGrey)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct CustomerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerHomeView()
    }
}
