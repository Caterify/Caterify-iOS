//
//  OrderViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation
import Combine

final class OrderViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    @Published var schedules: [Schedule] = []
    @Published var selected: CateringOrderStatus = .progress
    
    private var scheduleRequest = ScheduleRequest()
    private var cancellable = Set<AnyCancellable>()
    
    func getAllOrders() {
        scheduleRequest.getAllPrivateSchedules()
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    print("Error Fetching schedules: \(err.message!)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                self?.schedules = data.schedules!
                print(self?.schedules)
            }
            .store(in: &cancellable)
    }
    
    func changeStatus(scheduleId: Int, status: Int) {
        scheduleRequest.changeStatus(scheduleId: scheduleId, status: status)
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    print("Error Fetching schedules: \(err.message!)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                print(data.schedule)
            }
            .store(in: &cancellable)
    }
}
