//
//  CustomerSubscriptionViewModel.swift
//  Caterify
//
//  Created by Meichel Rendio on 21/11/21.
//

import Foundation
import Combine

final class CustomerSubscriptionViewModel: ObservableObject {
    @Published var orders: [Order] = []
    
    private let orderRequest = OrderRequest()
    private var cancellable = Set<AnyCancellable>()
    
    func getOrders() {
        orderRequest.getAllOrders()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    print("Error Fetching Orders: \(err.message!)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                self?.orders = data.orders.sorted { $0.schedule!.date!.toDate()! > $1.schedule!.date!.toDate()! }
                print("Debug order: \(self?.orders)")
            }
            .store(in: &cancellable)

    }
}
