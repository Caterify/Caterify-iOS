//
//  CreateMenuViewModel.swift
//  Caterify
//
//  Created by Joanda Febrian on 20/11/21.
//

import SwiftUI
import Combine

final class CreateMenuViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var image: UIImage?
    @Published var description: String = ""
    @Published var price: PriceInt = 0
    @Published var sourceType: UIImagePickerController.SourceType = .camera
    @Published var isShowingImagePicker: Bool = false
    @Published var isSelectingSourceType: Bool = false
    
    @Binding var date: Date
    
    private var scheduleRequest = ScheduleRequest()
    private var menuRequest = MenuRequest()
    private var cancellable = Set<AnyCancellable>()
    
    init(date: Binding<Date>) {
        self._date = date
    }
    
    func createMenu() {
        menuRequest.createMenu(name: name, description: description)
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
                guard let menu = data.menu else { return }
                self?.createSchedule(menu_id: menu.id!)
            }
            .store(in: &cancellable)

    }
    
    func createSchedule(menu_id: Int) {
        scheduleRequest.createSchedule(date: date.toString(), price: price, menu_id: menu_id)
            .receive(on: DispatchQueue.main, options: nil)
            .sink { result in
                switch result {
                case .finished:
                    print("Finished!")
                case .failure(let err):
                    print("Error Fetching Caterings: \(err.message!)")
                }
            } receiveValue: { responses in
                guard let data = responses.data else { return }
                print(data)
            }
            .store(in: &cancellable)

    }
}
