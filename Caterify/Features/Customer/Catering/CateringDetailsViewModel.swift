//
//  CateringDetailViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import Foundation
import Combine

final class CateringDetailsViewModel: ObservableObject {
    
    @Published var catering: Catering
    @Published var schedules: [Schedule] = []
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date().addingTimeInterval(6 * TimeInterval.day)
    @Published var totalPrice: Int?
    @Published var isDoneLoadingRangedSchedule: Bool = false
    var duration: TimeInterval = TimeInterval.week
    var count: Int {
        return schedules.count
    }
    var deliveryFee: Int {
        return count * 10000
    }
    var totalFee: Int {
        return deliveryFee + totalPrice!
    }
    
    private let scheduleRequest = ScheduleRequest()
    private var cancellable = Set<AnyCancellable>()
    
    init(_ catering: Catering) {
        self.catering = catering
    }
    
    func getSchedules() {
        isDoneLoadingRangedSchedule = false
        scheduleRequest.getScheduleInRange(id: catering.id!, start: startDate.toString(withFormat: "yyyy-MM-dd"), end: endDate.toString(withFormat: "yyyy-MM-dd"))
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    print("Error Fetching Schedules: \(err.message!)")
                }
            } receiveValue: { [weak self] responses in
                guard let data = responses.data else { return }
                self?.totalPrice = data.totalPrice
                self?.schedules = data.schedules
                self?.isDoneLoadingRangedSchedule = true
            }
            .store(in: &cancellable)

    }
    
}
