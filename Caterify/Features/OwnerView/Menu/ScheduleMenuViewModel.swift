//
//  ScheduleMenuViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation
import Combine

final class ScheduleMenuViewModel: ObservableObject {
    
    @Published var menu: Menu?
    @Published var date: Date = Date()
    @Published var price: Int = 0
    @Published var isDoneLoading: Bool = false
    
    private var scheduleRequest = ScheduleRequest()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        getActiveOrder()
    }
    
    func getActiveOrder() {
        isDoneLoading = false
        scheduleRequest.getScheduleOfCatering(date: date.toString(withFormat: "yyyy-MM-dd"))
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    print("Error Fetching Caterings: \(err.message!)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                let schedule = data.schedule
                self?.menu = schedule?.menu
                self?.price = schedule?.price ?? 0
                self?.isDoneLoading = true
                print(self?.menu)
            }
            .store(in: &cancellable)
    }
}
