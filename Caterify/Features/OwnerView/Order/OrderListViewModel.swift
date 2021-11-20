//
//  OrderListViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation

final class OrderListViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    
}
